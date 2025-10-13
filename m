Return-Path: <linux-tip-commits+bounces-6787-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B461BD6502
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Oct 2025 23:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31BD18A81B9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Oct 2025 21:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A7F281508;
	Mon, 13 Oct 2025 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vcLE2CbN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7nmA8+s7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB722367CF;
	Mon, 13 Oct 2025 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760389231; cv=none; b=HZiKVpsJ9eZ7vHnwIKgpz6Nj2uy4fu7U28nMYZVvLdqkKFbZyox7Yjs8l0pmddectsRQFCuxaPKoaRpFBQNMdKXDObt8XQEtKQ75GiNeycYukjXL4VHY2QO/8a7ep+uNa/C29rIi6wcQn0WnUIz97kgZewWlwfwAvk+Jaa5JzW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760389231; c=relaxed/simple;
	bh=+QCJ2Eioke85KtBzJkAOKqxeKTxeVaViEeiRMt3P1H4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=jHkENXErZLRTFJgjK3NX4Qyuw9LUKZnRZtbdJE56LrbPoePXrpUGKqpxoiRALbLE3YdjYEK0utfkWq3xHMCSk+3HYADlDC080nJKnzxJvs6OrlrEJQkQ5OR1Ogv0PzrdHmrRNrotOu6QCmxIrKJ7HFJ/f5M9/NdJiZp69dou0c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vcLE2CbN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7nmA8+s7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 13 Oct 2025 21:00:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760389227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=nHmyiSPQoY/7v+Wd4W9Az86IbaGLcGUBEN6d67ts+pU=;
	b=vcLE2CbN6aTJY/CtvwQXkqXf6VSwoeXv4DxMnA+7p+uLeWBT245zDr54lAZGCKCei7/iki
	rnrZiHp8I5THXoktZTVPXD308DweMlgVGBIMLZH7bj8Bp96LvP/DZoyBwgLAp+xuliOhu4
	UPT/97+6s/0DSuuTnpKqNfsdwlmKFX3eRTUA0Uv98kkmg2ZypKzweT31U3n+nyTEt0cNAw
	hmYapYgFIJZjvpyqdxA8MuFHVjotUpeTplGR9M087fxOGwWxkTYSeaWM0eVxbY30oWti4y
	ALBERpP+Z1faciQFkAfHzuJ/FAsfarEon3FISQr5hIId+qnFO95ZfrRb4EFebg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760389227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=nHmyiSPQoY/7v+Wd4W9Az86IbaGLcGUBEN6d67ts+pU=;
	b=7nmA8+s7clqsSezugSsOZTpmCUlKrn+UAhC7WGsVIniu68w/iX8UmpEZhoUiyzYFhDjYB/
	kkr9xOnjJg2FHXBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm: Fix SMP ordering in switch_mm_irqs_off()
Cc: Stephen Dolan <sdolan@janestreet.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176038922445.709179.9913480594037934552.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     83b0177a6c4889b3a6e865da5e21b2c9d97d0551
Gitweb:        https://git.kernel.org/tip/83b0177a6c4889b3a6e865da5e21b2c9d97=
d0551
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 16 May 2025 15:43:04 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 13 Oct 2025 13:55:53 -07:00

x86/mm: Fix SMP ordering in switch_mm_irqs_off()

Stephen noted that it is possible to not have an smp_mb() between
the loaded_mm store and the tlb_gen load in switch_mm(), meaning the
ordering against flush_tlb_mm_range() goes out the window, and it
becomes possible for switch_mm() to not observe a recent tlb_gen
update and fail to flush the TLBs.

[ dhansen: merge conflict fixed by Ingo ]

Fixes: 209954cbc7d0 ("x86/mm/tlb: Update mm_cpumask lazily")
Reported-by: Stephen Dolan <sdolan@janestreet.com>
Closes: https://lore.kernel.org/all/CAHDw0oGd0B4=3Duuv8NGqbUQ_ZVmSheU2bN70e4Q=
hFXWvuAZdt2w@mail.gmail.com/
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---
 arch/x86/mm/tlb.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 39f8011..5d22170 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -911,11 +911,31 @@ void switch_mm_irqs_off(struct mm_struct *unused, struc=
t mm_struct *next,
 		 * CR3 and cpu_tlbstate.loaded_mm are not all in sync.
 		 */
 		this_cpu_write(cpu_tlbstate.loaded_mm, LOADED_MM_SWITCHING);
-		barrier();
=20
-		/* Start receiving IPIs and then read tlb_gen (and LAM below) */
+		/*
+		 * Make sure this CPU is set in mm_cpumask() such that we'll
+		 * receive invalidation IPIs.
+		 *
+		 * Rely on the smp_mb() implied by cpumask_set_cpu()'s atomic
+		 * operation, or explicitly provide one. Such that:
+		 *
+		 * switch_mm_irqs_off()				flush_tlb_mm_range()
+		 *   smp_store_release(loaded_mm, SWITCHING);     atomic64_inc_return(tlb_=
gen)
+		 *   smp_mb(); // here                            // smp_mb() implied
+		 *   atomic64_read(tlb_gen);                      this_cpu_read(loaded_mm);
+		 *
+		 * we properly order against flush_tlb_mm_range(), where the
+		 * loaded_mm load can happen in mative_flush_tlb_multi() ->
+		 * should_flush_tlb().
+		 *
+		 * This way switch_mm() must see the new tlb_gen or
+		 * flush_tlb_mm_range() must see the new loaded_mm, or both.
+		 */
 		if (next !=3D &init_mm && !cpumask_test_cpu(cpu, mm_cpumask(next)))
 			cpumask_set_cpu(cpu, mm_cpumask(next));
+		else
+			smp_mb();
+
 		next_tlb_gen =3D atomic64_read(&next->context.tlb_gen);
=20
 		ns =3D choose_new_asid(next, next_tlb_gen);

