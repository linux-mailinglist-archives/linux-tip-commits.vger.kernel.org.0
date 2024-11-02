Return-Path: <linux-tip-commits+bounces-2750-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78259BA289
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 22:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F0C51F216B5
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 21:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4F11ABEBA;
	Sat,  2 Nov 2024 21:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vrp16pyG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nhZSo9pH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D17C1A7273;
	Sat,  2 Nov 2024 21:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730582614; cv=none; b=f78YlDIN3ZquEEHpaa3hO/pg5hQuhAUAtYDx/SReOh9RaXT5yjrzxwoz7G8vR+wijWWTjiKKzfHK+wF57MdefDOhfj3y3ojnj9QBzgRXoFLJtm/bW8zjEUZsUOTlEaxcFcgJn4pVvgQtWE0n3F/S6lG27DPq/bGQmZ2u6oPRcCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730582614; c=relaxed/simple;
	bh=kMFHwBNX1//mO5aPjmiUeubwIumRYgVuchqnV1jSLc0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=nXW8TYwM3OiCkfM1wGeSLXDjdaeHffDAPeyMUwoNtx76+s9rVZhTvfxjexkVy6/lfM50HIRnDyhCB4+oQyarVhFsPXX99wvtnQFaReO4BNK9dGSxeyB03w2PnV8zxoqC0xm0bZKVz0/06EV4IKINDVzxLRE8Eh3d/ZWk2TIlHRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vrp16pyG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nhZSo9pH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 21:23:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730582611;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=hlvn09gU9XTZSoOI8m4HOXLGTANTIv4yF8fPnTwmuy0=;
	b=Vrp16pyGowQ2jkm8Vip0JEwyGaJIaRwR21swdUZg59WE+lyPE3YF4L7j5PCN/SFwUxEFSO
	Hk0YjmgsjfqNU3OeM8esAO+Bf99V73tcLSixxPV8zv58zc5mR8mk+XsBYg3QzsIYwMUYUy
	hv9XXuO8qTCdTcweeSTU196wPN6KSFmR0UbrcD0F/b+rzxfbDympRdmyzAtVR4cEhsCPQt
	xL8fX+N2s7dQWNiOwsBxWyf9DXIVGeczVYxmUzbwAO/y2cTBsXwwaIOSwlKSQSwRvKi/gu
	rxkjfoIGqs9HLwPq3WPAoI1FKWYILvft8J/B+eSdTHgWjfv274li1oAK/i8CmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730582611;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=hlvn09gU9XTZSoOI8m4HOXLGTANTIv4yF8fPnTwmuy0=;
	b=nhZSo9pHZmfCvwR/6OhfVYf7BC1VwwFXHGHeqU0+ll5558dW6h35Kv1CkQ7hqkIJSv0T4R
	h/gVnO/XGSZTDlBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] x86/vdso: Add missing brackets in switch case
Cc: kernel test robot <lkp@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173058261037.3137.8690137124888546964.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     7fa3c36ea2707c495cf31ccab733ac8bf3f9d0c2
Gitweb:        https://git.kernel.org/tip/7fa3c36ea2707c495cf31ccab733ac8bf3f9d0c2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 02 Nov 2024 22:11:24 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 22:16:14 +01:00

x86/vdso: Add missing brackets in switch case

0-day reported:

  arch/x86/entry/vdso/vma.c:199:3: warning: label followed by a declaration
  				 	    is a C23 extension [-Wc23-extensions]

Add the missing brackets.

Fixes: e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated mapping")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Closes: https://lore.kernel.org/oe-kbuild-all/202411022359.fBPFTg2T-lkp@intel.com/
---
 arch/x86/entry/vdso/vma.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 7e5921a..bfc7cab 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -196,21 +196,26 @@ static vm_fault_t vvar_vclock_fault(const struct vm_special_mapping *sm,
 	switch (vmf->pgoff) {
 #ifdef CONFIG_PARAVIRT_CLOCK
 	case VDSO_PAGE_PVCLOCK_OFFSET:
+	{
 		struct pvclock_vsyscall_time_info *pvti =
 			pvclock_get_pvti_cpu0_va();
+
 		if (pvti && vclock_was_used(VDSO_CLOCKMODE_PVCLOCK))
 			return vmf_insert_pfn_prot(vma, vmf->address,
 					__pa(pvti) >> PAGE_SHIFT,
 					pgprot_decrypted(vma->vm_page_prot));
 		break;
+	}
 #endif /* CONFIG_PARAVIRT_CLOCK */
 #ifdef CONFIG_HYPERV_TIMER
 	case VDSO_PAGE_HVCLOCK_OFFSET:
+	{
 		unsigned long pfn = hv_get_tsc_pfn();
 
 		if (pfn && vclock_was_used(VDSO_CLOCKMODE_HVCLOCK))
 			return vmf_insert_pfn(vma, vmf->address, pfn);
 		break;
+	}
 #endif /* CONFIG_HYPERV_TIMER */
 	}
 

