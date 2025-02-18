Return-Path: <linux-tip-commits+bounces-3430-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F36A39799
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D3E97A5D0A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2D024503D;
	Tue, 18 Feb 2025 09:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uuxglqd5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cl8jBMi0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4BA243381;
	Tue, 18 Feb 2025 09:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739872006; cv=none; b=afsHgT0gWfT7OQcq5z49pc0ciPKZ19K1UX+O4oewSKno0PiE9j80/0EtuO1ppby09DLUEnIhO+CQF4COSTOG6VhczJojekKI2x6TgXSX5xcBsZ2zoN1f/K/Z8REF1lZ4Rod5iZz9KB6SFpG2L2ia9Z5tuDrYbefSFi4+y+M38rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739872006; c=relaxed/simple;
	bh=ZW8Ro9Jn5GVjNFgxmYY4BJ6ZqSov/gXNIN0pxvNtKNg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jpBiSYpG4087NMgsvua9wwlAiMrlBgxh9vnbhCc+kBBrkgTY4cG2oJdOgOM5sWJ96B2cuM8UTkPnj3UMzcPVqWJ7sAvbdBxOmmhDWAXNa8FKfdfc+QzeNx1KbXv7AW1U01gCUz/CpB5nMi+yraGpS7CEtHWBJqDlBhF8850shBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uuxglqd5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cl8jBMi0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:46:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739872003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJdSWp+JrLtw8SJ4+CyguPEZM15lwAbm5uuf4GiIBRE=;
	b=uuxglqd5FVtZKjbRdWkOpkYNo5laRhsXPvcUMWw4deN0pgHlRPBlVFN5O62/1Ws2JFx1Zo
	XLIrvXnb5qntrym9bEvbFeV9NFHpfhccavZq5SnSGU2UV9uzWctqmV3B4Ot8lySE0/jAQX
	EtmMYEH+NPCViaCDH6wNoLpyzLaZEMHIwlDEfq/PhL7EmkTsO/FXAAOkp4uoPmP1LZbUoy
	TtCjs+R0S43EoXh5ogDJneT0o2hJCcbObl6w60VKAhp4FBnjoVwJKf5pBc09QcvwcwQAVR
	Gc2gqIP2wcDmyX5GqyJ/DRCqBqMiLfa2CgphiU4ihxTBpK6RnSMDv9qdsFauvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739872003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XJdSWp+JrLtw8SJ4+CyguPEZM15lwAbm5uuf4GiIBRE=;
	b=cl8jBMi0HFGpIyK1+VYJNyLuj1GAGAuHPIMr1E0bzZGZB2j4zVWFzCPbL6uqmYPcth4PcF
	R8ynisd9Vwsa/CCQ==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] LoongArch: KVM: Switch to use hrtimer_setup()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Ca5b1b53813a15a73afdfff6fbb4c9064fa582be1=2E17387?=
 =?utf-8?q?46821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Ca5b1b53813a15a73afdfff6fbb4c9064fa582be1=2E173874?=
 =?utf-8?q?6821=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173987200270.10177.12442043416736596713.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     7d6f12520bd40f6e88e79de29808c7ae98185324
Gitweb:        https://git.kernel.org/tip/7d6f12520bd40f6e88e79de29808c7ae98185324
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Wed, 05 Feb 2025 11:38:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 10:32:31 +01:00

LoongArch: KVM: Switch to use hrtimer_setup()

hrtimer_setup() takes the callback function pointer as argument and
initializes the timer completely.

Replace hrtimer_init() and the open coded initialization of
hrtimer::function with the new setup mechanism.

Patch was created by using Coccinelle.

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/a5b1b53813a15a73afdfff6fbb4c9064fa582be1.1738746821.git.namcao@linutronix.de

---
 arch/loongarch/kvm/vcpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kvm/vcpu.c b/arch/loongarch/kvm/vcpu.c
index 20f941a..6230458 100644
--- a/arch/loongarch/kvm/vcpu.c
+++ b/arch/loongarch/kvm/vcpu.c
@@ -1459,8 +1459,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	vcpu->arch.vpid = 0;
 	vcpu->arch.flush_gpa = INVALID_GPA;
 
-	hrtimer_init(&vcpu->arch.swtimer, CLOCK_MONOTONIC, HRTIMER_MODE_ABS_PINNED_HARD);
-	vcpu->arch.swtimer.function = kvm_swtimer_wakeup;
+	hrtimer_setup(&vcpu->arch.swtimer, kvm_swtimer_wakeup, CLOCK_MONOTONIC,
+		      HRTIMER_MODE_ABS_PINNED_HARD);
 
 	vcpu->arch.handle_exit = kvm_handle_exit;
 	vcpu->arch.guest_eentry = (unsigned long)kvm_loongarch_ops->exc_entry;

