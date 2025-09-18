Return-Path: <linux-tip-commits+bounces-6490-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D59D4B456AB
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 13:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9263C48139F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 11:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9E93469F8;
	Fri,  5 Sep 2025 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4eeLvawz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KzBQyZFR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E2829B8F5;
	Fri,  5 Sep 2025 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072452; cv=none; b=iDT3FN6BzZa7qJo2C3kOAWHM+UCHlHEtSNj19TcqPV3s/vR5t9/G6vTEqFGHTQsbxYbu5mGRDzDXOtAPI62LWgjdsZ6MMMxwRSRIirq+lVff6aDOr1Qf2rMa+/U33GYIYltztxhBXN0sw8hoH3VDfoYyZvK70+1MnySKhpHrmmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072452; c=relaxed/simple;
	bh=qoM7KlhxcAYY/O2x93O98ub8Sw+i6ItYFYAAZrk5RnU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CQ5c/Xfwxcw9kWS2zcl4rVkSwoZjpwXmmZTMjoXfk5MEKThFNS4dgzO6g/mbwJcabRjKhR34DLaos4OUsMSPw+FilgSLQxORaU1+yavuwyIjfKa7lrbO6p9FzgHyCPn5yv2moN4gT2KKcSJfa/SZvlo7sK8I2Ke7hON1487nrgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4eeLvawz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KzBQyZFR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Sep 2025 11:40:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757072448;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yX9yw2zf1D2cADMRbOtHfldHS2PyMEE60r8fvyeg8Os=;
	b=4eeLvawzG4obqYRqt1L/Etdf00KFaKSH1Vucxx17bqI4gihLZKtn/7ZpBpeHoPFracJEOx
	6zKB4rpzirN2eL6CUyOSZ3NDgcwG0ymaYEctOeZFE/CFN/3PKNsb3l/MlsGRCZjtzFVTYw
	kgQ/Als016ihNT1J9AYc2fO1Z+K5BxJW4TZ2CrDkm1pP66+fsVP0r1W9UxgNiJcf02vvdg
	76usOEg8DUqU/5eocvHMGdLFJsFrogaldeh8FIep4vkabmWUEqeAv8N8a9YoDumgZBfbSC
	SUrRUNXc0AX8NO5tjdZrILo7Z/O9++ijcU9QsOo2xjtGYKYCSmZJVUvnJWNmsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757072448;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yX9yw2zf1D2cADMRbOtHfldHS2PyMEE60r8fvyeg8Os=;
	b=KzBQyZFRf45P5F1bSPdpSyKSpVDScgZDnPlS9S6Yqu03C97InN0TKlwubLA9Ms2sS0zK90
	aNxCLthjjGMuiEAw==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/amd: Put list_head in threshold_bank
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250624-wip-mca-updates-v4-8-236dd74f645f@amd.com>
References: <20250624-wip-mca-updates-v4-8-236dd74f645f@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175707244757.1920.2179436634776174619.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     c4bac5c640e3782bf30c07c4d82042d0202fe224
Gitweb:        https://git.kernel.org/tip/c4bac5c640e3782bf30c07c4d82042d0202=
fe224
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 24 Jun 2025 14:16:03=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 05 Sep 2025 12:42:21 +02:00

x86/mce/amd: Put list_head in threshold_bank

The threshold_bank structure is a container for one or more threshold_block
structures. Currently, the container has a single pointer to the 'first'
threshold_block structure which then has a linked list of the remaining
threshold_block structures.

This results in an extra level of indirection where the 'first' block is
checked before iterating over the remaining blocks.

Remove the indirection by including the head of the block list in the
threshold_bank structure which already acts as a container for all the bank's
thresholding blocks.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250624-wip-mca-updates-v4-8-236dd74f645f@amd.=
com
---
 arch/x86/kernel/cpu/mce/amd.c | 43 +++++++++-------------------------
 1 file changed, 12 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 7e36bc0..e9b9be2 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -241,7 +241,8 @@ struct threshold_block {
=20
 struct threshold_bank {
 	struct kobject		*kobj;
-	struct threshold_block	*blocks;
+	/* List of threshold blocks within this MCA bank. */
+	struct list_head	miscj;
 };
=20
 static DEFINE_PER_CPU(struct threshold_bank **, threshold_banks);
@@ -898,9 +899,9 @@ static void log_and_reset_block(struct threshold_block *b=
lock)
  */
 static void amd_threshold_interrupt(void)
 {
-	struct threshold_block *first_block =3D NULL, *block =3D NULL, *tmp =3D NUL=
L;
-	struct threshold_bank **bp =3D this_cpu_read(threshold_banks);
+	struct threshold_bank **bp =3D this_cpu_read(threshold_banks), *thr_bank;
 	unsigned int bank, cpu =3D smp_processor_id();
+	struct threshold_block *block, *tmp;
=20
 	/*
 	 * Validate that the threshold bank has been initialized already. The
@@ -914,16 +915,11 @@ static void amd_threshold_interrupt(void)
 		if (!(per_cpu(bank_map, cpu) & BIT_ULL(bank)))
 			continue;
=20
-		first_block =3D bp[bank]->blocks;
-		if (!first_block)
+		thr_bank =3D bp[bank];
+		if (!thr_bank)
 			continue;
=20
-		/*
-		 * The first block is also the head of the list. Check it first
-		 * before iterating over the rest.
-		 */
-		log_and_reset_block(first_block);
-		list_for_each_entry_safe(block, tmp, &first_block->miscj, miscj)
+		list_for_each_entry_safe(block, tmp, &thr_bank->miscj, miscj)
 			log_and_reset_block(block);
 	}
 }
@@ -1149,13 +1145,7 @@ static int allocate_threshold_blocks(unsigned int cpu,=
 struct threshold_bank *tb
 		default_attrs[2] =3D NULL;
 	}
=20
-	INIT_LIST_HEAD(&b->miscj);
-
-	/* This is safe as @tb is not visible yet */
-	if (tb->blocks)
-		list_add(&b->miscj, &tb->blocks->miscj);
-	else
-		tb->blocks =3D b;
+	list_add(&b->miscj, &tb->miscj);
=20
 	err =3D kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, get_name=
(cpu, bank, b));
 	if (err)
@@ -1206,6 +1196,8 @@ static int threshold_create_bank(struct threshold_bank =
**bp, unsigned int cpu,
 		goto out_free;
 	}
=20
+	INIT_LIST_HEAD(&b->miscj);
+
 	err =3D allocate_threshold_blocks(cpu, b, bank, 0, mca_msr_reg(bank, MCA_MI=
SC));
 	if (err)
 		goto out_kobj;
@@ -1226,26 +1218,15 @@ static void threshold_block_release(struct kobject *k=
obj)
 	kfree(to_block(kobj));
 }
=20
-static void deallocate_threshold_blocks(struct threshold_bank *bank)
+static void threshold_remove_bank(struct threshold_bank *bank)
 {
 	struct threshold_block *pos, *tmp;
=20
-	list_for_each_entry_safe(pos, tmp, &bank->blocks->miscj, miscj) {
+	list_for_each_entry_safe(pos, tmp, &bank->miscj, miscj) {
 		list_del(&pos->miscj);
 		kobject_put(&pos->kobj);
 	}
=20
-	kobject_put(&bank->blocks->kobj);
-}
-
-static void threshold_remove_bank(struct threshold_bank *bank)
-{
-	if (!bank->blocks)
-		goto out_free;
-
-	deallocate_threshold_blocks(bank);
-
-out_free:
 	kobject_put(bank->kobj);
 	kfree(bank);
 }

