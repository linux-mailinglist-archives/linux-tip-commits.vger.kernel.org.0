Return-Path: <linux-tip-commits+bounces-5462-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2880DAAF79C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144BB3A70EF
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE591F5F6;
	Thu,  8 May 2025 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AzTOfDD2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0m/ciSZR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0C317D2;
	Thu,  8 May 2025 10:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746699371; cv=none; b=ijY39KXR8uIU9g1B9eTEWuEPiXkCiXOkmm6MaFe3hLd1zZtfmnBYiLp0EeNZULC9Y9GMSlO5vZ330fRPCwQKbaCvEM2jPLhfmAbSmtgTcNA3IQzZdt/4yFwT8nNC0d0aNMMPJlqCJZHRre8K3qS63p+0mZIs0Im567mbDTGssz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746699371; c=relaxed/simple;
	bh=g9h5dBR2Tsdm0mcREJJsn0oHY2aSXNZVhw/mHH+l0co=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=lAeQrKOcAZM4qn+xfib6vYomXJNy4OVQZEA/1LLiIh/5bKLp5gz25IhSF14al9k8qfBhjrOT6SHnMaoE307coJJeSAt6ABNwDAf1wwFn2tWaaoXKumkLqekkoYrdXcI08jk+zxwiatfes9p1l9hVoqZ4bX3V7fDajqd2DC+TZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AzTOfDD2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0m/ciSZR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:16:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746699367;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=aF/ltaJhvwVmyjwdyXtxwXVYsg5WVaAE27ZAcO+kXgo=;
	b=AzTOfDD2QzoLSkcVpPLve+qa695CUR9AR349kJN7ya/Bk+SiyGWYPyN8G56zPyZZE9gF6d
	n2F9gck2jpqBokpIOqTdNQbj4OwtZVRQmffIhdhpkzrMR/PmF4BIwI63Z8IIX1kACz6C0V
	Vdv1VP7uVIjzr3FpjlnitanB1g7NFxIOtZm10NXUxFU2GtF+ogDayo8jLZjroUx9nxPR2h
	VPCTR0vhzDncBJ2F80/aL3HqCgea164DPUiR5LlIby3aRsZPoMOT3wy0GDDKRXRMEyAdkR
	NvggXQpazwRV/CoJqig6OZ0N/11UV5NwjbfMKuHZkmH81uBXJs5y2TcOsE1pGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746699367;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=aF/ltaJhvwVmyjwdyXtxwXVYsg5WVaAE27ZAcO+kXgo=;
	b=0m/ciSZRsotRBgudkW8T9KbDkq8wIJdEVNOMG0Al5f9/WThbXoDfugOhLlIsJ0kAFe2NBw
	CSC4z6Gp60i9gnDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq/cpuhotplug: Fix up lock guards conversion brainf..t
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174669936666.406.16351332287608705670.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c855506257063f444044d0a85a2e9ad9ab1c7ecd
Gitweb:        https://git.kernel.org/tip/c855506257063f444044d0a85a2e9ad9ab1c7ecd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 08 May 2025 12:05:38 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 May 2025 12:05:38 +02:00

genirq/cpuhotplug: Fix up lock guards conversion brainf..t

The lock guard conversion converted raw_spin_lock_irq() to
scoped_guard(raw_spinlock), which is obviously bogus and makes lockdep
mightily unhappy.

Note to self: Copy and pasta without using brain is a patently bad idea.

Fixes: 88a4df117ad6 ("genirq/cpuhotplug: Convert to lock guards")
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Borislav Petkov <bp@alien8.de>
---
 kernel/irq/cpuhotplug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
index 7bd4c2a..e77ca6d 100644
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -243,7 +243,7 @@ int irq_affinity_online_cpu(unsigned int cpu)
 	irq_lock_sparse();
 	for_each_active_irq(irq) {
 		desc = irq_to_desc(irq);
-		scoped_guard(raw_spinlock, &desc->lock)
+		scoped_guard(raw_spinlock_irq, &desc->lock)
 			irq_restore_affinity_of_irq(desc, cpu);
 	}
 	irq_unlock_sparse();

