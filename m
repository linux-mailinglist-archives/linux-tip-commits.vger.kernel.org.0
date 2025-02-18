Return-Path: <linux-tip-commits+bounces-3435-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E1AA397AB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BB8C7A6169
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D05248186;
	Tue, 18 Feb 2025 09:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iBq1QBop";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x/2Xrpn4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C670C24633A;
	Tue, 18 Feb 2025 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872010; cv=none; b=smhMG5OeIOYSNZ1Tlxl90EwHAKbNQ5AfTQWWUHl3NZm7id50K0rSnFOFIEXFjEhs6A3Ub+bjF+l34tQd6CWqkWJnvEGcc0zzqpXMfbZwusSMOg59eA3C75NxPE5DqjrjtXGMAUONTGHZx6rXKhzfSh/cLz+nN/EtTVxlIrem8OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872010; c=relaxed/simple;
	bh=6miZpBU1VXDQU4wsMArQc9RnDcarALzmmKmgAUos/WQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gtkIu7cj0/YyXqcRZfzTQuIe88DkYbCWT6Fb1sc2BmbekTRUPtzpVT/cbcuA64vRmL282P/sRna0l65RedgRuj9No2S/WFXnswXeNBDx9zJSGPokFSlV5ZEnHTNQdv2a6eZybpBaitCoywtuk3AxjkuFqKgkBvgrPehUSQwOiHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iBq1QBop; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x/2Xrpn4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739872006;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kxdf5dHVNgLn0mYfX7uP24afZvLmcTpDz4+NAOyxmic=;
	b=iBq1QBopq8ldElpBhMSUQzoM2NE/cP8P0aXTL6hStlJdmuIlPJGMJwkZybjZurrRDM1XvD
	ZvQWAGNabFhJg/hMJJyk2CQbi7+DwbH2eRnK9J6M0icSmo/+aCKio+h3kH5dSQhSEkl7AC
	C+IVmIcJ6QqiP7wNHLEQrQxz317e+fokJ5uvpMBaq6vH9plExEybIrfWH6+vu4ecqKW+aR
	/fSJwHl5MnjoADjU038yz0wWBRmdltrp6eFtYIp1dZ6ANY194xmcXD53v8MYmNcSPSeO6x
	M5shAdy07jOOtR1oRrMqawdE3qFoVdOEkSB6i7UP1Vo4T7FeLq7o+/Wabk1rRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739872006;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kxdf5dHVNgLn0mYfX7uP24afZvLmcTpDz4+NAOyxmic=;
	b=x/2Xrpn4DW8hacIYDkADIxYz7fb1OZr3fcAEtAwh9kHILaArTXHi3PrrfTm5VHpgpkNpQb
	8V2PUMoGjujn8VBQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] KVM: MIPS: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C34004267eba24388fb50ef6de1b8dd7addba6475=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C34004267eba24388fb50ef6de1b8dd7addba6475=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987200599.10177.2431762137460377503.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     c97f85ddd60a5a87058ddc1054f0396c3524ae0f
Gitweb:        https://git.kernel.org/tip/c97f85ddd60a5a87058ddc1054f0396c3524ae0f
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:38:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:30 +01:00

KVM: MIPS: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/34004267eba24388fb50ef6de1b8dd7addba6475.1738746821.git.namcao@linutronix.de

---
 arch/mips/kvm/mips.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 60b43ea..cef3c42 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -288,9 +288,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	if (err)
 		return err;
 
-	hrtimer_init(&vcpu->arch.comparecount_timer, CLOCK_MONOTONIC,
-		     HRTIMER_MODE_REL);
-	vcpu->arch.comparecount_timer.function = kvm_mips_comparecount_wakeup;
+	hrtimer_setup(&vcpu->arch.comparecount_timer, kvm_mips_comparecount_wakeup, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_REL);
 
 	/*
 	 * Allocate space for host mode exception handlers that handle

