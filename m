Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E7433C285
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Mar 2021 17:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhCOQxW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Mar 2021 12:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233562AbhCOQxM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Mar 2021 12:53:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60EBC06174A;
        Mon, 15 Mar 2021 09:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KENSFBrgL7G8DHdTp+gR5QWnEIhaP8QPJlJ0A6o62Gk=; b=hpn5s+Vhfg1OqLp8SNfZI0pVi+
        ZsujCKNxkFeL/YcnABjrqPPkuIh7HMYzRFKhg5sdtJLetjm0b2noamfEA1Xe8abcdBJ1gcIEAPiXV
        IX04eSTXqa9uVWIA1JDp10E5K685K8+wO7+v3AiyXD3QvptEj+jE88lSJYByIHWFJWhX2TVr6bLXn
        yEbBcjB4XGlAfRmLBlMiwMF7mOkNLDwMB5RuHs3rQ61Hxmwq/a0a2+alKY4205Grptz+cMMhr1yZW
        xoBDiFbtCvh6qX/xMSma9rGCIYqqb7t1Z5+gvZO2uhMdtTKtftnkG+gcC2jxzh1nQ+d+iH/ehp7bB
        L9T3CZ5Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lLqSq-00GOuD-7h; Mon, 15 Mar 2021 16:53:09 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D196D300130;
        Mon, 15 Mar 2021 17:53:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BCB772D1CBC16; Mon, 15 Mar 2021 17:53:07 +0100 (CET)
Date:   Mon, 15 Mar 2021 17:53:07 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org
Subject: Re: [tip: x86/core] x86/insn: Add an insn_decode() API
Message-ID: <YE+Q84RB7X/y93CB@hirez.programming.kicks-ass.net>
References: <20210304174237.31945-5-bp@alien8.de>
 <161582326890.398.5378343352256538882.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161582326890.398.5378343352256538882.tip-bot2@tip-bot2>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Mon, Mar 15, 2021 at 03:47:48PM -0000, tip-bot2 for Borislav Petkov wrote:
> x86/insn: Add an insn_decode() API

Seeing as how I'm a lazy sod, does we want something like so?

--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -150,6 +150,8 @@ enum insn_mode {
 
 extern int insn_decode(struct insn *insn, const void *kaddr, int buf_len, enum insn_mode m);
 
+#define insn_decode_kernel(_insn, _ptr) insn_decode((_insn), (_ptr), MAX_INSN_SIZE, INSN_MODE_KERN)
+
 /* Attribute will be determined after getting ModRM (for opcode groups) */
 static inline void insn_get_attribute(struct insn *insn)
 {
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1333,7 +1333,7 @@ static void text_poke_loc_init(struct te
 	if (!emulate)
 		emulate = opcode;
 
-	ret = insn_decode(&insn, emulate, MAX_INSN_SIZE, INSN_MODE_KERN);
+	ret = insn_decode_kernel(&insn, emulate);
 
 	BUG_ON(ret < 0);
 	BUG_ON(len != insn.length);
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -225,7 +225,7 @@ static bool is_copy_from_user(struct pt_
 	if (copy_from_kernel_nofault(insn_buf, (void *)regs->ip, MAX_INSN_SIZE))
 		return false;
 
-	ret = insn_decode(&insn, insn_buf, MAX_INSN_SIZE, INSN_MODE_KERN);
+	ret = insn_decode_kernel(&insn, insn_buf);
 	if (ret < 0)
 		return false;
 
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -279,7 +279,7 @@ static int can_probe(unsigned long paddr
 		if (!__addr)
 			return 0;
 
-		ret = insn_decode(&insn, (void *)__addr, MAX_INSN_SIZE, INSN_MODE_KERN);
+		ret = insn_decode_kernel(&insn, (void *)__addr);
 		if (ret < 0)
 			return 0;
 
@@ -316,7 +316,7 @@ int __copy_instruction(u8 *dest, u8 *src
 			MAX_INSN_SIZE))
 		return 0;
 
-	ret = insn_decode(insn, dest, MAX_INSN_SIZE, INSN_MODE_KERN);
+	ret = insn_decode_kernel(insn, dest);
 	if (ret < 0)
 		return 0;
 
--- a/arch/x86/kernel/kprobes/opt.c
+++ b/arch/x86/kernel/kprobes/opt.c
@@ -324,7 +324,7 @@ static int can_optimize(unsigned long pa
 		if (!recovered_insn)
 			return 0;
 
-		ret = insn_decode(&insn, (void *)recovered_insn, MAX_INSN_SIZE, INSN_MODE_KERN);
+		ret = insn_decode_kernel(&insn, (void *)recovered_insn);
 		if (ret < 0)
 			return 0;
 
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -504,7 +504,7 @@ static enum kernel_gp_hint get_kernel_gp
 			MAX_INSN_SIZE))
 		return GP_NO_HINT;
 
-	ret = insn_decode(&insn, insn_buf, MAX_INSN_SIZE, INSN_MODE_KERN);
+	ret = insn_decode_kernel(&insn, insn_buf);
 	if (ret < 0)
 		return GP_NO_HINT;
 
