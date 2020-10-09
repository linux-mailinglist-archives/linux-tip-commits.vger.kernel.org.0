Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16782899FC
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 22:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbgJIUtg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 16:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727311AbgJIUtf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 16:49:35 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498DEC0613D2;
        Fri,  9 Oct 2020 13:49:35 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0bdf0020b374afa9964fe5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:df00:20b3:74af:a996:4fe5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 84A481EC030E;
        Fri,  9 Oct 2020 22:49:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602276571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oSMm+8VUQ5rLiTiiCL2NSdz7x452mwfi8Gr9Y0TQ/mM=;
        b=is1vnyinGTyG5peLKV93eqgIlJFLaUna+nQpJ38EYqiN+51TLCHMpYVG243nGQb7nECns8
        Xo+9gj0WLbK9ouln05djQcFIbVI7g4GKcJQRB2Db8/AYYiJ8tfyi7tIE8wjLh3sntN5e6G
        VQ6ki17uGsPnUcU4p7KWEWt6kJvL8Zs=
Date:   Fri, 9 Oct 2020 22:49:21 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>
Subject: Re: [tip: objtool/core] x86/insn: Support big endian cross-compiles
Message-ID: <20201009204921.GB21731@zn.tnic>
References: <160208761921.7002.1321765913567405137.tip-bot2@tip-bot2>
 <20201009203822.GA2974@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201009203822.GA2974@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Oct 09, 2020 at 10:38:22PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 07, 2020 at 04:20:19PM -0000, tip-bot2 for Martin Schwidefsky wrote:
> > The following commit has been merged into the objtool/core branch of tip:
> > 
> > Commit-ID:     2a522b53c47051d3bf98748418f4f8e5f20d2c04
> > Gitweb:        https://git.kernel.org/tip/2a522b53c47051d3bf98748418f4f8e5f20d2c04
> > Author:        Martin Schwidefsky <schwidefsky@de.ibm.com>
> > AuthorDate:    Mon, 05 Oct 2020 17:50:31 +02:00
> > Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
> > CommitterDate: Tue, 06 Oct 2020 09:32:29 -05:00
> > 
> > x86/insn: Support big endian cross-compiles
> > 
> > x86 instruction decoder code is shared across the kernel source and the
> > tools. Currently objtool seems to be the only tool from build tools needed
> > which breaks x86 cross compilation on big endian systems. Make the x86
> > instruction decoder build host endianness agnostic to support x86 cross
> > compilation and enable objtool to implement endianness awareness for
> > big endian architectures support.
> > 
> > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
> > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> 
> This commit breaks the x86 build with CONFIG_X86_DECODER_SELFTEST=y.
> 
> I've asked Boris to truncate tip/objtool/core.

Yeah, top 4 are gone until this is resolved.

What I would suggest is to have a look at how tools/ headers are kept
separate from kernel proper ones, see tools/include/ and how those
headers there are full of dummy definitions just so it builds.

And then including a global one like linux/kernel.h is just looking for
trouble:

In file included from ./include/uapi/linux/byteorder/little_endian.h:12,
                 from ./include/linux/byteorder/little_endian.h:5,
                 from /usr/include/x86_64-linux-gnu/asm/byteorder.h:5,
                 from ./arch/x86/include/asm/insn.h:10,
                 from arch/x86/tools/insn_sanity.c:21:
./tools/include/linux/types.h:30:18: error: conflicting types for ‘u64’
   30 | typedef uint64_t u64;
      |                  ^~~
In file included from /usr/include/asm-generic/types.h:7,
                 from /usr/include/x86_64-linux-gnu/asm/types.h:1,
                 from ./tools/include/linux/types.h:10,
                 from ./include/uapi/linux/byteorder/little_endian.h:12,
                 from ./include/linux/byteorder/little_endian.h:5,
                 from /usr/include/x86_64-linux-gnu/asm/byteorder.h:5,
                 from ./arch/x86/include/asm/insn.h:10,
                 from arch/x86/tools/insn_sanity.c:21:
./include/asm-generic/int-ll64.h:23:15: note: previous declaration of ‘u64’ was here
   23 | typedef __u64 u64;
      |               ^~~
In file included from ./include/uapi/linux/byteorder/little_endian.h:12,
                 from ./include/linux/byteorder/little_endian.h:5,
                 from /usr/include/x86_64-linux-gnu/asm/byteorder.h:5,
                 from ./arch/x86/include/asm/insn.h:10,
                 from arch/x86/tools/insn_sanity.c:21:
./tools/include/linux/types.h:31:17: error: conflicting types for ‘s64’
   31 | typedef int64_t s64;
      |                 ^~~
In file included from /usr/include/asm-generic/types.h:7,
                 from /usr/include/x86_64-linux-gnu/asm/types.h:1,
                 from ./tools/include/linux/types.h:10,
                 from ./include/uapi/linux/byteorder/little_endian.h:12,
                 from ./include/linux/byteorder/little_endian.h:5,
                 from /usr/include/x86_64-linux-gnu/asm/byteorder.h:5,
                 from ./arch/x86/include/asm/insn.h:10,
                 from arch/x86/tools/insn_sanity.c:21:
./include/asm-generic/int-ll64.h:22:15: note: previous declaration of ‘s64’ was here
   22 | typedef __s64 s64;
      |               ^~~
In file included from ./arch/x86/lib/insn.c:8,
                 from arch/x86/tools/insn_sanity.c:23:
./tools/include/linux/kernel.h:87: warning: "cpu_to_le16" redefined
   87 | #define cpu_to_le16
      | 
In file included from ./include/linux/byteorder/little_endian.h:11,
                 from /usr/include/x86_64-linux-gnu/asm/byteorder.h:5,
                 from ./arch/x86/include/asm/insn.h:10,
                 from arch/x86/tools/insn_sanity.c:21:
./include/linux/byteorder/generic.h:90: note: this is the location of the previous definition
   90 | #define cpu_to_le16 __cpu_to_le16
      | 
In file included from ./arch/x86/lib/insn.c:8,
                 from arch/x86/tools/insn_sanity.c:23:
./tools/include/linux/kernel.h:88: warning: "cpu_to_le32" redefined
   88 | #define cpu_to_le32
      | 
In file included from ./include/linux/byteorder/little_endian.h:11,
                 from /usr/include/x86_64-linux-gnu/asm/byteorder.h:5,
                 from ./arch/x86/include/asm/insn.h:10,
                 from arch/x86/tools/insn_sanity.c:21:
./include/linux/byteorder/generic.h:88: note: this is the location of the previous definition
   88 | #define cpu_to_le32 __cpu_to_le32
      | 
In file included from ./arch/x86/lib/insn.c:8,
                 from arch/x86/tools/insn_sanity.c:23:
./tools/include/linux/kernel.h:89: warning: "cpu_to_le64" redefined
   89 | #define cpu_to_le64
      | 
In file included from ./include/linux/byteorder/little_endian.h:11,
                 from /usr/include/x86_64-linux-gnu/asm/byteorder.h:5,
                 from ./arch/x86/include/asm/insn.h:10,
                 from arch/x86/tools/insn_sanity.c:21:
./include/linux/byteorder/generic.h:86: note: this is the location of the previous definition
   86 | #define cpu_to_le64 __cpu_to_le64
      | 
In file included from ./arch/x86/lib/insn.c:8,
                 from arch/x86/tools/insn_sanity.c:23:
./tools/include/linux/kernel.h:90: warning: "le16_to_cpu" redefined
   90 | #define le16_to_cpu
      | 
In file included from ./include/linux/byteorder/little_endian.h:11,
                 from /usr/include/x86_64-linux-gnu/asm/byteorder.h:5,
                 from ./arch/x86/include/asm/insn.h:10,
                 from arch/x86/tools/insn_sanity.c:21:
./include/linux/byteorder/generic.h:91: note: this is the location of the previous definition
   91 | #define le16_to_cpu __le16_to_cpu
      | 
In file included from ./arch/x86/lib/insn.c:8,
                 from arch/x86/tools/insn_sanity.c:23:
./tools/include/linux/kernel.h:91: warning: "le32_to_cpu" redefined
   91 | #define le32_to_cpu
      | 
In file included from ./include/linux/byteorder/little_endian.h:11,
                 from /usr/include/x86_64-linux-gnu/asm/byteorder.h:5,
                 from ./arch/x86/include/asm/insn.h:10,
                 from arch/x86/tools/insn_sanity.c:21:
./include/linux/byteorder/generic.h:89: note: this is the location of the previous definition
   89 | #define le32_to_cpu __le32_to_cpu
      | 
In file included from ./arch/x86/lib/insn.c:8,
                 from arch/x86/tools/insn_sanity.c:23:
./tools/include/linux/kernel.h:92: warning: "le64_to_cpu" redefined
   92 | #define le64_to_cpu
      | 
In file included from ./include/linux/byteorder/little_endian.h:11,
                 from /usr/include/x86_64-linux-gnu/asm/byteorder.h:5,
                 from ./arch/x86/include/asm/insn.h:10,
                 from arch/x86/tools/insn_sanity.c:21:
./include/linux/byteorder/generic.h:87: note: this is the location of the previous definition
   87 | #define le64_to_cpu __le64_to_cpu
      | 
In file included from ./arch/x86/lib/insn.c:8,
                 from arch/x86/tools/insn_sanity.c:23:
./tools/include/linux/kernel.h:93: warning: "cpu_to_be16" redefined
   93 | #define cpu_to_be16 bswap_16
      | 
In file included from ./include/linux/byteorder/little_endian.h:11,
                 from /usr/include/x86_64-linux-gnu/asm/byteorder.h:5,
                 from ./arch/x86/include/asm/insn.h:10,
                 from arch/x86/tools/insn_sanity.c:21:
./include/linux/byteorder/generic.h:96: note: this is the location of the previous definition
   96 | #define cpu_to_be16 __cpu_to_be16
      | 
In file included from ./arch/x86/lib/insn.c:8,
                 from arch/x86/tools/insn_sanity.c:23:
./tools/include/linux/kernel.h:94: warning: "cpu_to_be32" redefined
   94 | #define cpu_to_be32 bswap_32
      | 
In file included from ./include/linux/byteorder/little_endian.h:11,
                 from /usr/include/x86_64-linux-gnu/asm/byteorder.h:5,
                 from ./arch/x86/include/asm/insn.h:10,
                 from arch/x86/tools/insn_sanity.c:21:
./include/linux/byteorder/generic.h:94: note: this is the location of the previous definition
   94 | #define cpu_to_be32 __cpu_to_be32
      | 
In file included from ./arch/x86/lib/insn.c:8,
                 from arch/x86/tools/insn_sanity.c:23:
./tools/include/linux/kernel.h:95: warning: "cpu_to_be64" redefined
   95 | #define cpu_to_be64 bswap_64
      | 
In file included from ./include/linux/byteorder/little_endian.h:11,
                 from /usr/include/x86_64-linux-gnu/asm/byteorder.h:5,
                 from ./arch/x86/include/asm/insn.h:10,
                 from arch/x86/tools/insn_sanity.c:21:
./include/linux/byteorder/generic.h:92: note: this is the location of the previous definition
   92 | #define cpu_to_be64 __cpu_to_be64
      | 
In file included from ./arch/x86/lib/insn.c:8,
                 from arch/x86/tools/insn_sanity.c:23:
./tools/include/linux/kernel.h:96: warning: "be16_to_cpu" redefined
   96 | #define be16_to_cpu bswap_16
      | 
In file included from ./include/linux/byteorder/little_endian.h:11,
                 from /usr/include/x86_64-linux-gnu/asm/byteorder.h:5,
                 from ./arch/x86/include/asm/insn.h:10,
                 from arch/x86/tools/insn_sanity.c:21:
./include/linux/byteorder/generic.h:97: note: this is the location of the previous definition
   97 | #define be16_to_cpu __be16_to_cpu
      | 
In file included from ./arch/x86/lib/insn.c:8,
                 from arch/x86/tools/insn_sanity.c:23:
./tools/include/linux/kernel.h:97: warning: "be32_to_cpu" redefined
   97 | #define be32_to_cpu bswap_32
      | 
In file included from ./include/linux/byteorder/little_endian.h:11,
                 from /usr/include/x86_64-linux-gnu/asm/byteorder.h:5,
                 from ./arch/x86/include/asm/insn.h:10,
                 from arch/x86/tools/insn_sanity.c:21:
./include/linux/byteorder/generic.h:95: note: this is the location of the previous definition
   95 | #define be32_to_cpu __be32_to_cpu
      | 
In file included from ./arch/x86/lib/insn.c:8,
                 from arch/x86/tools/insn_sanity.c:23:
./tools/include/linux/kernel.h:98: warning: "be64_to_cpu" redefined
   98 | #define be64_to_cpu bswap_64
      | 
In file included from ./include/linux/byteorder/little_endian.h:11,
                 from /usr/include/x86_64-linux-gnu/asm/byteorder.h:5,
                 from ./arch/x86/include/asm/insn.h:10,
                 from arch/x86/tools/insn_sanity.c:21:
./include/linux/byteorder/generic.h:93: note: this is the location of the previous definition
   93 | #define be64_to_cpu __be64_to_cpu
      | 
In file included from ./arch/x86/lib/insn.c:8,
                 from arch/x86/tools/insn_sanity.c:23:
./tools/include/linux/kernel.h:105: warning: "ARRAY_SIZE" redefined
  105 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
      | 
arch/x86/tools/insn_sanity.c:19: note: this is the location of the previous definition
   19 | #define ARRAY_SIZE(a) (sizeof(a)/sizeof(a[0]))
      | 
make[1]: *** [scripts/Makefile.host:95: arch/x86/tools/insn_sanity] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [arch/x86/Makefile:267: bzImage] Error 2
make: *** Waiting for unfinished jobs....

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
