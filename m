Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA726316D28
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 18:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbhBJRqs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 12:46:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33112 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhBJRqo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 12:46:44 -0500
Date:   Wed, 10 Feb 2021 17:45:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612979155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QhpO4wtRHBVDqOi6Ibrcz7CIBBDNPJaomOUcCEk9Exc=;
        b=UsmbD4I8PKm2kvJ7BntT1kNAmHPugGfF3Wwk7GLgnq39umWvpZul1/Uv4OtXvHIyxoa9ye
        DtEEEJj7h32u/NCSvlY5MfsHaRNfB7D7e9HscleDLlO53gE9GId9birbpupvj+hfnhajHY
        t3430HPQj7a1q2aG4dZnoaqURXSS/ivdOAY7bLANRNJfnpRBMUi6Eu5gBGH2+SBRjWx3PR
        SGopHbTNRlglHoftbfX5DClF8431+AYad6gXRWaWWI5SaJDstwKWGyVRU4IQEL4U/sJ4yP
        GQX0fGwVFQ8dbK9dbuFI8Mtj9ombmAONC5CW7HMWLuITv8IRFj6I3YtMpTDM/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612979155;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QhpO4wtRHBVDqOi6Ibrcz7CIBBDNPJaomOUcCEk9Exc=;
        b=6Bt0oRgAGt55sT3EPghPHzFgixMTBd9joLmkBPEo9UwuYqJZ5xVZue//DG1sx0qne0fU+e
        AYDlL4vqxyIICGDQ==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/fault: Don't run fixups for SMAP violations
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <66a02343624b1ff46f02a838c497fc05c1a871b3.1612924255.git.luto@kernel.org>
References: <66a02343624b1ff46f02a838c497fc05c1a871b3.1612924255.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <161297915451.23325.5119224707479092069.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     ca247283781d754216395a41c5e8be8ec79a5f1c
Gitweb:        https://git.kernel.org/tip/ca247283781d754216395a41c5e8be8ec79a5f1c
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Tue, 09 Feb 2021 18:33:45 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 10 Feb 2021 16:27:57 +01:00

x86/fault: Don't run fixups for SMAP violations

A SMAP-violating kernel access is not a recoverable condition.  Imagine
kernel code that, outside of a uaccess region, dereferences a pointer to
the user range by accident.  If SMAP is on, this will reliably generate
as an intentional user access.  This makes it easy for bugs to be
overlooked if code is inadequately tested both with and without SMAP.

This was discovered because BPF can generate invalid accesses to user
memory, but those warnings only got printed if SMAP was off. Make it so
that this type of error will be discovered with SMAP on as well.

 [ bp: Massage commit message. ]

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/66a02343624b1ff46f02a838c497fc05c1a871b3.1612924255.git.luto@kernel.org
---
 arch/x86/mm/fault.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 1a0cfed..1c3054b 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1279,9 +1279,12 @@ void do_user_addr_fault(struct pt_regs *regs,
 	 */
 	if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
 		     !(error_code & X86_PF_USER) &&
-		     !(regs->flags & X86_EFLAGS_AC)))
-	{
-		bad_area_nosemaphore(regs, error_code, address);
+		     !(regs->flags & X86_EFLAGS_AC))) {
+		/*
+		 * No extable entry here.  This was a kernel access to an
+		 * invalid pointer.  get_kernel_nofault() will not get here.
+		 */
+		page_fault_oops(regs, error_code, address);
 		return;
 	}
 
