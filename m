Return-Path: <linux-tip-commits+bounces-3429-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BE2A397AE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF8C3A4034
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19142244E87;
	Tue, 18 Feb 2025 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZuZ7wh1H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UKJDpIWO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BB5243375;
	Tue, 18 Feb 2025 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872006; cv=none; b=QpUVzwDI11QtnEwq08v9ipE0rlpTr5azSZepjsJUI8Ges+OBw9w0X6wPYwhYONVjsrSJm7PgC+DoEN14IHCLpdj9maJTBDQuvYRu9L71uBdztr2Dkbdl26qcyjNCF4dc3A1mQhlsCwDBC48EKimDbiLdU2x+uL/ycKxjw4dRf00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872006; c=relaxed/simple;
	bh=jluPD2RyoTPMnTekP/6lCFPI8wwiWlRTkub/HqNhMwY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ENioZjGnAKyJo/noxMcv3AiJTVqwiwB/sYrMfjJbEqlNr7K9q9zml/63C3HleN6fkkXymcESpn4DNGvShmLe1a3B78wxf8Qn8wMIDTNuV8S17oMDwwkxSLZsr79JRYOn2lAm6BBhzf52nvg111BcqGCuOFnCkfH8DNfAcfBztQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZuZ7wh1H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UKJDpIWO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739872002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=axuzZQxCGYo6y5zxXk4YPAk3+XxmvGm98LnYKfLTHpk=;
	b=ZuZ7wh1HHJeizxK062KvwJBfnAyJ0yfDN2HAL2L2kNjKGDCPcO76Hz/SQvNSnTCJxx6rH7
	jS9hWDd4vjDfuMM/byojFK9glUtBY+srVBfh5LvH9t+UhsCDiNB8fTgiA6Pq2hmT7REA3q
	NbKcsSRDEcBa9Lu4dgh0WWKZ9Wy+sNrvJ+BTq5Hmmua9BowbwJLb01fmJbpLlfJ7jvLqrM
	iWXfCY7mRC4ZMZLpdJgyGGwkgTbmZWuSPZZlhZhlcPQto3922v4ZKyDrHqEbalMk9a6zwI
	2Xj0CGral+lPvWU/pLlk43RhAhfMPmb4DRPu62EVjncXLLqEIzxTtcJDBhq3TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739872002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=axuzZQxCGYo6y5zxXk4YPAk3+XxmvGm98LnYKfLTHpk=;
	b=UKJDpIWO7c0+7a6jYTF4++oe57ed1ojfA5E+cbHO9lAgmPvUuTbLM2TBzydz/CVmukvlPE
	d6VtRzV0fiGdkZBw==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] riscv: kvm: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cd5ededf778f59f2fc38ff4276fb7f4c893e4142c=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cd5ededf778f59f2fc38ff4276fb7f4c893e4142c=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987200207.10177.549270278413675938.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     92051cb9d3e115533ff7c36ddae4e6888ac12869
Gitweb:        https://git.kernel.org/tip/92051cb9d3e115533ff7c36ddae4e6888ac12869
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:38:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:31 +01:00

riscv: kvm: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/d5ededf778f59f2fc38ff4276fb7f4c893e4142c.1738746821.git.namcao@linutronix.de

---
 arch/riscv/kvm/vcpu_timer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kvm/vcpu_timer.c b/arch/riscv/kvm/vcpu_timer.c
index 96e7a4e..ff672fa 100644
--- a/arch/riscv/kvm/vcpu_timer.c
+++ b/arch/riscv/kvm/vcpu_timer.c
@@ -248,18 +248,19 @@ int kvm_riscv_vcpu_timer_init(struct kvm_vcpu *vcpu)
 	if (t->init_done)
 		return -EINVAL;
 
-	hrtimer_init(&t->hrt, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	t->init_done = true;
 	t->next_set = false;
 
 	/* Enable sstc for every vcpu if available in hardware */
 	if (riscv_isa_extension_available(NULL, SSTC)) {
 		t->sstc_enabled = true;
-		t->hrt.function = kvm_riscv_vcpu_vstimer_expired;
+		hrtimer_setup(&t->hrt, kvm_riscv_vcpu_vstimer_expired, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 		t->timer_next_event = kvm_riscv_vcpu_update_vstimecmp;
 	} else {
 		t->sstc_enabled = false;
-		t->hrt.function = kvm_riscv_vcpu_hrtimer_expired;
+		hrtimer_setup(&t->hrt, kvm_riscv_vcpu_hrtimer_expired, CLOCK_MONOTONIC,
+			      HRTIMER_MODE_REL);
 		t->timer_next_event = kvm_riscv_vcpu_update_hrtimer;
 	}
 

