Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5348528A24A
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 00:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390264AbgJJW4v (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 10 Oct 2020 18:56:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55012 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731510AbgJJTbl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 10 Oct 2020 15:31:41 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09AE5SER134724;
        Sat, 10 Oct 2020 10:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=pp1;
 bh=/N/kyXgMafqEpTZf8F9LKYHKSmD5eDnZgaNGCH1ICU0=;
 b=S/pZXPikzzo3Tq3qwD/SADN4U/+bj4IfcS7/QNBXbxjYZw+nlMjGVytBYrtUWmxgOr7N
 F2XNvepVl/VAK4oSuSbfCd6+owq/n3VTDiZQ2IfQlEbxJwpzFIKN27H4HP906am/SBAQ
 lQDbiiAAtoQWOJCy3/f1oJXGzb1hI21We2fvA0sSzpmhdSoQepGN7qmb39i5SF9pOOKu
 hAO7dmykFX+nllo66mWiRtvo9qBJ+Mu24AA6N6CV1VMOg+2WDn5Nwa7IOFGTS/gEXY8d
 qbKzgt/eBniIP7GYY1YPLmz4AoLoYouRalvfhxCpNZNLLgaBbBSlsrix5CUeR6uWvPad vg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 343dqtrjv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Oct 2020 10:07:18 -0400
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09AE5pDO135409;
        Sat, 10 Oct 2020 10:07:18 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 343dqtrjuy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Oct 2020 10:07:18 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09ADvHNp022566;
        Sat, 10 Oct 2020 14:02:15 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 34347h06fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Oct 2020 14:02:15 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09AE2C5d22675712
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 10 Oct 2020 14:02:13 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8CED9A4053;
        Sat, 10 Oct 2020 14:02:12 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09439A4055;
        Sat, 10 Oct 2020 14:02:12 +0000 (GMT)
Received: from localhost (unknown [9.145.82.174])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 10 Oct 2020 14:02:11 +0000 (GMT)
Date:   Sat, 10 Oct 2020 16:02:10 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        x86 <x86@kernel.org>
Subject: Re: [tip: objtool/core] x86/insn: Support big endian cross-compiles
Message-ID: <your-ad-here.call-01602338530-ext-4703@work.hours>
References: <160208761921.7002.1321765913567405137.tip-bot2@tip-bot2>
 <20201009203822.GA2974@worktop.programming.kicks-ass.net>
 <20201009204921.GB21731@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201009204921.GB21731@zn.tnic>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-10_07:2020-10-09,2020-10-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 malwarescore=0 clxscore=1011 bulkscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010100128
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Fri, Oct 09, 2020 at 10:49:21PM +0200, Borislav Petkov wrote:
> On Fri, Oct 09, 2020 at 10:38:22PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 07, 2020 at 04:20:19PM -0000, tip-bot2 for Martin Schwidefsky wrote:
> > > The following commit has been merged into the objtool/core branch of tip:
> > > 
> > > Commit-ID:     2a522b53c47051d3bf98748418f4f8e5f20d2c04
> > > Gitweb:        https://git.kernel.org/tip/2a522b53c47051d3bf98748418f4f8e5f20d2c04
> > > 
> > > x86/insn: Support big endian cross-compiles
> > 
> > This commit breaks the x86 build with CONFIG_X86_DECODER_SELFTEST=y.
> > 
> > I've asked Boris to truncate tip/objtool/core.
> 
> Yeah, top 4 are gone until this is resolved.
> 
> What I would suggest is to have a look at how tools/ headers are kept
> separate from kernel proper ones, see tools/include/ and how those
> headers there are full of dummy definitions just so it builds.
> 
> And then including a global one like linux/kernel.h is just looking for
> trouble:
> 
> In file included from ./include/uapi/linux/byteorder/little_endian.h:12,
>                  from ./include/linux/byteorder/little_endian.h:5,
>                  from /usr/include/x86_64-linux-gnu/asm/byteorder.h:5,
>                  from ./arch/x86/include/asm/insn.h:10,
>                  from arch/x86/tools/insn_sanity.c:21:
> ./tools/include/linux/types.h:30:18: error: conflicting types for ‘u64’
>    30 | typedef uint64_t u64;

Sigh... I have not realized there are more usages of insn.c which are
conditionally compiled. It's not like you grep *.c files to find who
includes them regularity.

Looks like there is no way to find common byte swapping helpers for
the kernel and tools then. Even though tools provide quite a bunch of
them in tools/include/. So, completely avoiding mixing "kernel" and
"userspace" headers would look like the following (delta to commit
mentioned above):
---

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 004e27bdf121..68197fe18a11 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -7,7 +7,13 @@
  * Copyright (C) IBM Corporation, 2009
  */
 
+#ifdef __KERNEL__
 #include <asm/byteorder.h>
+#define insn_cpu_to_le32 cpu_to_le32
+#else
+#include <endian.h>
+#define insn_cpu_to_le32 htole32
+#endif
 /* insn_attr_t is defined in inat.h */
 #include <asm/inat.h>
 
@@ -47,7 +53,7 @@ static inline void insn_field_set(struct insn_field *p, insn_value_t v,
 				  unsigned char n)
 {
 	p->value = v;
-	p->little = __cpu_to_le32(v);
+	p->little = insn_cpu_to_le32(v);
 	p->nbytes = n;
 }
 
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 520b31fc1f1a..003f32ff7798 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -5,7 +5,6 @@
  * Copyright (C) IBM Corporation, 2002, 2004, 2009
  */
 
-#include <linux/kernel.h>
 #ifdef __KERNEL__
 #include <linux/string.h>
 #else
@@ -16,15 +15,23 @@
 
 #include <asm/emulate_prefix.h>
 
+#ifdef __KERNEL__
+#define insn_le32_to_cpu le32_to_cpu
+#define insn_le16_to_cpu le16_to_cpu
+#else
+#define insn_le32_to_cpu le32toh
+#define insn_le16_to_cpu le16toh
+#endif
+
 #define leXX_to_cpu(t, r)						\
 ({									\
 	__typeof__(t) v;						\
 	switch (sizeof(t)) {						\
-	case 4: v = le32_to_cpu(r); break;				\
-	case 2: v = le16_to_cpu(r); break;				\
+	case 4: v = insn_le32_to_cpu(r); break;				\
+	case 2: v = insn_le16_to_cpu(r); break;				\
 	case 1:	v = r; break;						\
-	default:							\
-		BUILD_BUG(); break;					\
+	default: /* relying on -Wuninitialized to report this */	\
+		break;							\
 	}								\
 	v;								\
 })
--
And the same for the tools/*
No linux/kernel.h means no BUILD_BUG(), but -Wuninitialized actually
does a decent job in this case:
arch/x86/../../../arch/x86/lib/insn.c:605:37: error: variable 'v' is
		uninitialized when used here [-Werror,-Wuninitialized]
                insn_field_set(&insn->immediate2, get_next(long, insn), 1);
                                                  ^~~~~~~~~~~~~~~~~~~~

Masami, Josh,
would that be acceptable?

Should I resent the entire patch series again with these changes squashed?
Or just as a separate commit which would go on top?
