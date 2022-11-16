import 'package:flutter/material.dart';

class SearchBarProduct extends StatefulWidget {
  const SearchBarProduct({Key? key}) : super(key: key);

  @override
  State<SearchBarProduct> createState() => _SearchBarProductState();
}

class _SearchBarProductState extends State<SearchBarProduct> {
  TextEditingController controller = TextEditingController();

  // final String? errorText;
  // final String? labelText;
  // final double height;
  //
  // _SearchBarProductState({
  //   Key? key,
  //   this.errorText,
  //   this.labelText,
  //   this.controller,
  //   this.height = 80,
  // });

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.symmetric(vertical: _size.height/50),

      child: TextField(
        controller: controller,
        // maxLength: 32,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            suffixIcon: const Icon(Icons.search_outlined),
            hintText: "search",
          contentPadding: const EdgeInsets.symmetric(horizontal: 15)

        ),
        onChanged: (value) {
          setState(() {});
        },
      ),
    );

    // shadow
    // const errorStyle = TextStyle(
    //   fontSize: 14,
    // );
    //
    // // Wrap everything in LayoutBuilder so that the available maxWidth is taken into account for the height calculation (important if you error text exceeds one line)
    // return LayoutBuilder(builder: (context, constraints){
    //   // Use tp to calculate the height of the errorText
    //   final textPainter = TextPainter()
    //     ..text = TextSpan(text: errorText, style: errorStyle)
    //     ..textDirection = TextDirection.ltr
    //     ..layout(maxWidth: constraints.maxWidth);
    //
    //   final heightErrorMessage = textPainter.size.height + 8;
    //   return Stack(
    //     children: [
    //       // Separate container with identical height of text field which is placed behind the actual textfield
    //       Container(
    //         height: height,
    //         decoration: BoxDecoration(
    //           boxShadow: const [
    //             BoxShadow(
    //               color: Colors.grey,
    //               blurRadius: 3,
    //               offset: Offset(3, 3),
    //             ),
    //           ],
    //           borderRadius: BorderRadius.circular(
    //             10.0,
    //           ),
    //         ),
    //       ),
    //       Container(
    //         // Add height of error message if it is displayed
    //         height: errorText != null ? height + heightErrorMessage : height,
    //         child: TextField(
    //           decoration: InputDecoration(
    //             fillColor: Colors.white,
    //             filled: true,
    //             errorStyle: errorStyle,
    //             errorText: errorText,
    //             border: OutlineInputBorder(
    //               borderRadius: BorderRadius.circular(
    //                 10.0,
    //               ),
    //             ),
    //             labelText: labelText,
    //           ),
    //           controller: controller,
    //         ),
    //       ),
    //     ],
    //   );
    // });
  }
}
