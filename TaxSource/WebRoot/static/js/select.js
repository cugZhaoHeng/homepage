//三个select的id所表示的元素
var province=$("#province"),city=$("#city"),town=$("#town");
//这三个变量贯穿整个文档，当前select选中的option的文本内容
var provinceText,cityText,provinceIndex;

//对id值为province添加省级列表的文本，如北京/湖北，provinceList是个json数组，在另一个文档中包含全中国所有的省
for(var i=0;i<provinceList.length;i++){
    addEle(province,provinceList[i].name);
}
function addEle(ele,value){
    var optionStr="";
    optionStr="<option value="+value+">"+value+"</option>";
    ele.append(optionStr);
}
function removeEle(ele){
	//删除该select所有的选项，只重新赋值一个option——“请选择"
    ele.find("option").remove();
    var optionStar="<option value="+"请选择"+">"+"请选择"+"</option>";
    ele.append(optionStar);
}


//当省级列表选项改变时，获取当前的文本值，如湖北，并且将市级select的下拉文本也改变，具体实现如下：
province.on("change",function(){
	//获取id为province的select的省所选中的内容，是一个省名
    provinceText=$(this).val();
    //对于函数each(data, function(index, val){})来说，data是一个json数组，index表示当前数组data的下标，而val表示当前下标所对应的json对象
    $.each(provinceList,function(i,item){
    	//遍历provinceList数组，如果选中的为湖北，则返回湖北省所在的index下标
        if(provinceText == item.name){
            provinceIndex=i;
            //这里的return有什么用吗？
            return provinceIndex;
        }
    });
    //清除掉市和县的select并设置为“请选择”
    removeEle(city);
    removeEle(town);
    //遍历湖北省的市的json数组，i表示市的序号，item表示市的json对象，该json对象包含的是县和区的json数组，这里不讨论
    $.each(provinceList[provinceIndex].cityList,function(i,item){
    	//将所有市的名称添加到当前id为“city”的的select列表中
        addEle(city,item.name)
    })
});
//同理，当市级select的选项改变时，相对应的县级select也要改变，具体实现如下：
city.on("change",function(){
	//获得选中的市的名称
    cityText=$(this).val();
    //清空县级select的选型
    removeEle(town);
    //这个检测省的遍历是必需的吗？是否可省掉？其目的市返回当前选择的省的名称，通过这，可以获取provinceIndex，但是provinceIndex已经在之前获得了吧？
    //事实证明，这一段是可以注释掉的
   /* $.each(provinceList,function(i,item){
        if(provinceText == item.name){
            provinceIndex=i;
            return provinceIndex
        }
    });*/
    
    //遍历该省下面所有的市
    $.each(provinceList[provinceIndex].cityList,function(i,item){
    	//如果当前选中的市被遍历到了，那么就将该市所辖的所有的县（区）都添加到select的id为town的下拉列表中
        if(cityText == item.name){
            for(var n=0;n<item.areaList.length;n++){
                addEle(town,item.areaList[n])
            }
        }
    });
});