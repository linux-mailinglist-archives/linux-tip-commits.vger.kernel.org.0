Return-Path: <linux-tip-commits+bounces-3434-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4ABDA39793
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C5B162410
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B0B2475E4;
	Tue, 18 Feb 2025 09:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UL2mXM8l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BOHBFqT2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0D7246335;
	Tue, 18 Feb 2025 09:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872009; cv=none; b=leepAO8l5aqhUcZdMz6FUQFRE+Ua/P7nKoqsOadicDiYxQVSCXk1Xob2Oxp8KvnxQhtqe+fACP2/fZppd89/CIWThdZIPZvHn1MUINrWlst310wic4vP0Z3BbAl2DTqyVZQA4J96FT6N+UuyRbqR6SMqht7Ce7b1BDBkKZxFs04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872009; c=relaxed/simple;
	bh=5J1JCnlrPEyC3wKj5hlfaP8vPKgl5X42BUKi5TPNLdw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M2X6P4ftq6uVixJPxj+sT3p3VlaA4dx3c+/y0auT01Evffs5GxNL8qpHt/3eppnKG2uguFchjEIA6zuPjNgAP6ylQpQHt1dXAxOh5n039EQFZE58dhDl3t+b0oWvqg6HuCTwCPEr6hFLZsUQ+SZA91nTSuEp0pkhYp22sd4Kv7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UL2mXM8l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BOHBFqT2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739872005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0el+vZOLLGmlZA+e1CSulntccrWgwxv9M5Q6sS5J0uw=;
	b=UL2mXM8lC1NkC/P5SZn46TpcoIlX5ezk4o1ppt1ZhksS9v6dK1hNCpB1enE74cYB6aS4gk
	UlRwLKjgEe1O+8d5DblIPRleg9+nziOaTB0dfj0va8tV3BrTYE+nkcU4PG7rB8MnfKf8Mf
	zNvsf4USXEes2KR7pQbkxz53zFBE+Jv6BK5Uyj5p/9GpleJIzZ4xw7s9mT0cRDvrZNUd67
	l8l5lf1j/mwZtA6FKcgXKnL8RZLH90n2Ez4F6qrniA0oxnhk60av3oFK/laySqWlM47g1l
	liWMtJn9fLaLerwuQ/SlocFmdtDr8wmyLK14zNumPnE8xZm97xzejlqmzKw7lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739872005;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0el+vZOLLGmlZA+e1CSulntccrWgwxv9M5Q6sS5J0uw=;
	b=BOHBFqT2WGpY3yJM6PKsXCUsDCEp2yA9RhwrKUCcIHMk8xA/e00G5LY5NCq2IO7hBanmHn
	s/jSDKz1Rqf/usCQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] KVM: PPC: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ca58c4f16b1cfba13f96201fda355553850a97562=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Ca58c4f16b1cfba13f96201fda355553850a97562=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987200535.10177.7528400490473745436.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     a0241210a3f3950bf4a28b5077108c8a126d47ec
Gitweb:        https://git.kernel.org/tip/a0241210a3f3950bf4a28b5077108c8a126d47ec
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:38:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:30 +01:00

KVM: PPC: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/a58c4f16b1cfba13f96201fda355553850a97562.1738746821.git.namcao@linutronix.de

---
 arch/powerpc/kvm/powerpc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index ce1d91e..61f2b7e 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -766,8 +766,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 {
 	int err;
 
-	hrtimer_init(&vcpu->arch.dec_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
-	vcpu->arch.dec_timer.function = kvmppc_decrementer_wakeup;
+	hrtimer_setup(&vcpu->arch.dec_timer, kvmppc_decrementer_wakeup, CLOCK_REALTIME,
+		      HRTIMER_MODE_ABS);
 
 #ifdef CONFIG_KVM_EXIT_TIMING
 	mutex_init(&vcpu->arch.exit_timing_lock);

