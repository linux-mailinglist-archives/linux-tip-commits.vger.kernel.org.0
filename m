Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4270540B7D6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Sep 2021 21:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232822AbhINTU4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Sep 2021 15:20:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35352 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233009AbhINTUu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Sep 2021 15:20:50 -0400
Date:   Tue, 14 Sep 2021 19:19:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631647172;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fPILGyTJUwFCqymTy7hjrUX+EPZRt7dzvr21DNA9wt0=;
        b=eEramHwDtG84jojIdvBK+gJrCcG3ROyFNNzAhWQhgMnnqm2pzwsCH2AWNzQWIHx1d4MGuW
        GAyXcsg6U1Xs+GQqBOHrYqjpi1bam4nhmJRJ3Pnc3swK1hITrZoIygC6IAmjBne5giitpx
        hT4VhjjzdJYIOJcRFPvo9qqjtaK2EWMrgydYiQZnWATPNHWa7zERSQbi8ZoN4rhowhGiXx
        7hqYA4JXPICbLm895x/NNlFfAsjAul6/6Y+9qOsoBSKWyK3A9k9sCqhxUULE/04AWgbRad
        ErKC1UpH6kVIYf95fwzQ7gZMvEmSu1dnKxZBByhuSG7FgVVDdp6cAyrLAlZUrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631647172;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fPILGyTJUwFCqymTy7hjrUX+EPZRt7dzvr21DNA9wt0=;
        b=EMzdYTz0yVctksVL3ZBh4xatnREh62CXTdpbMvdNCvJZ6Ww+zyXWrYMURVzTn6RaZT1RWP
        7MVUK4/CvEJICtDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/extable: Remove EX_TYPE_FAULT from MCE safe fixups
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210908132525.445255957@linutronix.de>
References: <20210908132525.445255957@linutronix.de>
MIME-Version: 1.0
Message-ID: <163164717172.25758.13914549878374483404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     0c2e62ba04cd0b7194b380bae4fc35c45bb2e46e
Gitweb:        https://git.kernel.org/tip/0c2e62ba04cd0b7194b380bae4fc35c45bb2e46e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Sep 2021 15:29:24 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Sep 2021 18:23:00 +02:00

x86/extable: Remove EX_TYPE_FAULT from MCE safe fixups

Now that the MC safe copy and FPU have been converted to use the MCE safe
fixup types remove EX_TYPE_FAULT from the list of types which MCE considers
to be safe to be recovered in kernel.

This removes the SGX exception handling of ENCLS from the #MC safe
handling, but according to the SGX wizards the current SGX implementations
cannot survive #MC on ENCLS:

  https://lore.kernel.org/r/YS+upEmTfpZub3s9@google.com

The code relies on the trap number being stored if ENCLS raised an
exception. That's still working, but it does no longer trick the MCE code
into assuming that #MC is handled correctly for ENCLS.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210908132525.445255957@linutronix.de
---
 arch/x86/kernel/cpu/mce/severity.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index d9b77a7..f60bbaf 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -277,7 +277,6 @@ static int error_context(struct mce *m, struct pt_regs *regs)
 			return IN_KERNEL;
 		m->kflags |= MCE_IN_KERNEL_COPYIN;
 		fallthrough;
-	case EX_TYPE_FAULT:
 	case EX_TYPE_FAULT_MCE_SAFE:
 	case EX_TYPE_DEFAULT_MCE_SAFE:
 		m->kflags |= MCE_IN_KERNEL_RECOV;
