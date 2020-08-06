Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC41923DDC5
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Aug 2020 19:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730284AbgHFRO1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 Aug 2020 13:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730206AbgHFRJ4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 Aug 2020 13:09:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B0EC061574;
        Thu,  6 Aug 2020 10:09:55 -0700 (PDT)
Date:   Thu, 06 Aug 2020 17:09:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596733793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0IfDYCyrpOkq4cmxc1Tqa4VZc19IKhfIyezM8UnI2Pg=;
        b=RWFCzw5AvxwIuVk3MEpBqIPepmQuV2m3tPeZOAcF1Hd4xJjna2IIHpEfkGO4ErOLhPkGxe
        VDGQEzxkAvukHWgMc7vmH7OHI6g0CxIU+rJX9MdKTRMtwkGIFANBu8X3qOjnSwYQLy29ki
        0hg3z3p6zE8e6+Su4lKV5MPbMSxr+sKXn4Py+GHdFDCW7QTzuIFC3hNwdkUfKiG7yDTK+K
        QwLMpO2Ns9C2Q8m+32Q6Yi7G3ywoLSLy3MxKpUlAumc7uSxG/8z7/5gb8nokhDmsEn92RL
        c5sVK0oErMQ5mTf/iUGR6RJ4TCFm8wbocleBDFyC4xH4gVPLqJAy25M4dGHj+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596733793;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0IfDYCyrpOkq4cmxc1Tqa4VZc19IKhfIyezM8UnI2Pg=;
        b=jIGFwuAIXvTsnDCz+IY8ShcX6rnpSfQYztmes6UQ1o8JBBbXSXkYWV8i/1SssAGwITWnVl
        o68fCXUWTdgThEAw==
From:   "tip-bot2 for Masami Hiramatsu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] kprobes: Remove show_registers() function prototype
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159673379297.3192.4747957589177383846.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     09fc67b500c7f0bb1b5ed774197ac7f2c5285655
Gitweb:        https://git.kernel.org/tip/09fc67b500c7f0bb1b5ed774197ac7f2c5285655
Author:        Masami Hiramatsu <mhiramat@kernel.org>
AuthorDate:    Fri, 17 Jul 2020 17:42:55 +09:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Aug 2020 17:52:28 +02:00

kprobes: Remove show_registers() function prototype

Remove show_registers() function prototype because this function
has been renamed by commit:

  57da8b960b9a ("x86: Avoid double stack traces with show_regs()")

and this commit has removed the caller in kprobes altogether:

  80006dbee674 ("kprobes/x86: Remove jprobe implementation")

So this doesn't exist anymore - remove the orphan prototype.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/kprobes.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 45b8cdc..9be1bff 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -227,7 +227,6 @@ extern int arch_prepare_kprobe(struct kprobe *p);
 extern void arch_arm_kprobe(struct kprobe *p);
 extern void arch_disarm_kprobe(struct kprobe *p);
 extern int arch_init_kprobes(void);
-extern void show_registers(struct pt_regs *regs);
 extern void kprobes_inc_nmissed_count(struct kprobe *p);
 extern bool arch_within_kprobe_blacklist(unsigned long addr);
 extern int arch_populate_kprobe_blacklist(void);
