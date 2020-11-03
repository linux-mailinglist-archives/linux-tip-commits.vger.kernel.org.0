Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4C642A5039
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Nov 2020 20:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgKCTf1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 3 Nov 2020 14:35:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:62476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725957AbgKCTf1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 3 Nov 2020 14:35:27 -0500
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A3JXH1j054347;
        Tue, 3 Nov 2020 14:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=yJVK0p7OTPVLnh9heLWN7XzBBJHmhTORtbVuKHXpgxY=;
 b=X7I5wHIm7VjOdrQw2o5Vh1wlNBxXhIkUeJYimAitVinlk099EIMlgPTizyoUL++qtQr4
 X0pU54WJKvwpHKmn0jWOV6nnfZncqLuo8aC7FN4ndHJgC5lW4ERhg/x3DJQp3ifr5yPz
 l5MMV8qWlxfocyCCOW3TsDc1KWf6ptsPbx+oydQllgCgfbOJCit0BlYxckncgWkKZQt4
 7BEXdVjT7O8m+EbryyWRtksDWCp1uFubvh0yE+lPrPZEq38W/jSRBEzDVhhCghLI+BRV
 UKq+WCzMj0sKAQMftLXHwHaqNC5KNACtKuBISA3IOCJyNFBubCqwIdMGc/stK499TwlF 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34kbppbdtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 14:35:15 -0500
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0A3JXfnE055436;
        Tue, 3 Nov 2020 14:35:14 -0500
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34kbppbdsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 14:35:14 -0500
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0A3JRjDL007981;
        Tue, 3 Nov 2020 19:35:11 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 34jbytrxgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Nov 2020 19:35:11 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0A3JZ8dC9437740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Nov 2020 19:35:09 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFD3AA4060;
        Tue,  3 Nov 2020 19:35:08 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87F11A4064;
        Tue,  3 Nov 2020 19:35:06 +0000 (GMT)
Received: from localhost (unknown [9.145.42.130])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  3 Nov 2020 19:35:05 +0000 (GMT)
Date:   Tue, 3 Nov 2020 20:35:00 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86 <x86@kernel.org>
Subject: Re: [tip: objtool/core] x86/insn: Support big endian cross-compiles
Message-ID: <cover.thread-59328d.your-ad-here.call-01604429777-ext-1374@work.hours>
References: <20201014162859.987d5f71f5e5456ffb812abc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201014162859.987d5f71f5e5456ffb812abc@kernel.org>
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-03_08:2020-11-03,2020-11-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 clxscore=1011 impostorscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011030130
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Wed, Oct 14, 2020 at 04:28:59PM +0900, Masami Hiramatsu wrote:
> On Mon, 12 Oct 2020 10:39:49 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > On Mon, Oct 12, 2020 at 09:12:36AM +0900, Masami Hiramatsu wrote:
> > > On Sat, 10 Oct 2020 12:44:15 -0500
> > > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > 
> > > > On Fri, Oct 09, 2020 at 10:49:21PM +0200, Borislav Petkov wrote:
> > > > > On Fri, Oct 09, 2020 at 10:38:22PM +0200, Peter Zijlstra wrote:
> > > > > > On Wed, Oct 07, 2020 at 04:20:19PM -0000, tip-bot2 for Martin Schwidefsky wrote:
> > > > > > > The following commit has been merged into the objtool/core branch of tip:
> > > > > > > 
> > > > > > > Commit-ID:     2a522b53c47051d3bf98748418f4f8e5f20d2c04
> > > > > > > Gitweb:        https://git.kernel.org/tip/2a522b53c47051d3bf98748418f4f8e5f20d2c04
> > > > > > > Author:        Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > > > > > AuthorDate:    Mon, 05 Oct 2020 17:50:31 +02:00
> > > > > > > Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
> > > > > > > CommitterDate: Tue, 06 Oct 2020 09:32:29 -05:00
> > > > > > > 
> > > > > > > x86/insn: Support big endian cross-compiles
> > > > > > > 
> > > > > > > x86 instruction decoder code is shared across the kernel source and the
> > > > > > > tools. Currently objtool seems to be the only tool from build tools needed
> > > > > > > which breaks x86 cross compilation on big endian systems. Make the x86
> > > > > > > instruction decoder build host endianness agnostic to support x86 cross
> > > > > > > compilation and enable objtool to implement endianness awareness for
> > > > > > > big endian architectures support.
> > > > > > > 
> > > > > > > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > > > > > > Co-developed-by: Vasily Gorbik <gor@linux.ibm.com>
> > > > > > > Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> > > > > > > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > > > > > > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > > > > > 
> > > > > > This commit breaks the x86 build with CONFIG_X86_DECODER_SELFTEST=y.
> > > > > > 
> > > > > > I've asked Boris to truncate tip/objtool/core.
> > > > > 
> > > > > Yeah, top 4 are gone until this is resolved.
> > > > 
> > > > Masami, I wonder if we even need these selftests anymore?  Objtool
> > > > already decodes the entire kernel.
> > > 
> > > No, they have different roles. The selftest checks if the decoder
> > > works correctly by comparing with the output of objdump.
> > > 
> > > As far as I can see, the objtool relies on the sanity of the decoder
> > > (it trusts the output of the decoder).
> > 
> > Ok.  I wonder if we should move the decoder selftest to the 'tools'
> > subdirectory.
> 
> It is in the arch/x86/tools, so it is already in a kind of tools :)
> But yeah, it was considered to be used only on x86. But if someone
> start trying to run it on non-x86, cross compiling, we need to
> reconsider that.

I actually tried to move it to tools/testing/selftests and encountered
several problems with kselftest build in general:
- out of source build is broken if path is relative,
- out of source build headers partially installed in
  $(srcdir)arch/x86/include/generated/ instead of $(objdir), when
  kselftests are called from the kbuild,
- out of source test runs is broken,
- kernel headers are installed unconditionally.

These things impede moving decoder selftests to kselftests.

On the other hand making the decoder selftest work "in place" seems
trivial. The following fix on top of jpoimboe/objtool/core fixes the
build, as well as cross-compilation. With that I can cross-compile
x86 kernel on s390 with CONFIG_X86_DECODER_SELFTEST=y and posttest runs
just fine.

Vasily Gorbik (1):
  x86/tools: Use tools headers for instruction decoder selftests

 arch/x86/tools/Makefile      | 8 ++++----
 arch/x86/tools/insn_sanity.c | 4 ----
 2 files changed, 4 insertions(+), 8 deletions(-)

-- 
2.25.4
