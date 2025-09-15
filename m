Return-Path: <linux-tip-commits+bounces-6638-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F206BB58723
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 00:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3782618923F3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 22:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF78A2877D3;
	Mon, 15 Sep 2025 22:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZfhdS/QH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Nf55ADZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0782E1DB95E;
	Mon, 15 Sep 2025 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757973898; cv=none; b=cYFFlQkOrxTlqCfhveG1CewL4qMLP8ryokvlZqh50p9KdOBYENmHbUSFk3juBbgebsYd3Cr2bjtYVWtYvdj5BlY0xG7ByeARctL7xlHWUVUBFx+KPiGKv+s7s2RuhCVRk7VPBo26cD8TJZ1Y2CNbQu4dfa+7Mz7WesJJep7moKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757973898; c=relaxed/simple;
	bh=QHhf/7bBiZdrVvOVStZvUjbCj9fxi+XoGBWGh783NNw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Qs/rJwY7vKxDeQwCx7QPNy1cmn3G0i/7JiLSzwL4BQ0IKrX7V08L7918m7Vj9dEKmlryBx4DVN6IpYgZwwDd/AfAa/9Vc/n0ccbgiJ506dt2nelMqgFANmx8rGEnf4LRTDQxHwr4ysBZLmpC9Q7bzG4E7WruujSxzM5CNjJ6QjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZfhdS/QH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Nf55ADZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 22:04:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757973895;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cGfX7uYH4b5XvyYqP69iMKYidsUuoQvW80jgIITdbEI=;
	b=ZfhdS/QH5Q+wvJhaGKffc+5DzYgKuRXP90bai/Sjwe+xICYFvtoXmd8wUHr6jOne/oYTlK
	3JXuJWXxFUx02XprL/y7gSTgSXl20LS9Z9KLHsD01IDX4+/8vw83/TLoOjHl0l4V4FPeZ2
	mK+azpxO5pkti68HFzVxK34KZcKimmDgVwUwl8PGtIVToeO0Hl9dVWElMRDH1PKySPbvqj
	4zYPMqQ6o5pkcy05kg6Y3GIG/73rwGonOZf32VAdx/l7qxvf6Q4AyHLBa9IxQm7fHdSMSS
	hjwQoKVtWZGyMExaMGyarwuQz+oFnmr9lIV66ocOtujFILgv9m9HqwUHfsn0Qg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757973895;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cGfX7uYH4b5XvyYqP69iMKYidsUuoQvW80jgIITdbEI=;
	b=9Nf55ADZC3AS4NTjGZKAe2IONj4tvoBpUqP9Fmnn87UOd6aHZ//tGHzxdtzbtcx1M/nIR+
	3vLY9YpzjKhfF7DA==
From: "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev: Guard sev_evict_cache() with
 CONFIG_AMD_MEM_ENCRYPT
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, stable@kernel.org,
	#@tip-bot2.tec.linutronix.de, 6.16.x@tip-bot2.tec.linutronix.de,
	x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175797389339.709179.7449727928740128362.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     7f830e126dc357fc086905ce9730140fd4528d66
Gitweb:        https://git.kernel.org/tip/7f830e126dc357fc086905ce9730140fd45=
28d66
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Mon, 15 Sep 2025 11:04:12 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 18:29:43 +02:00

x86/sev: Guard sev_evict_cache() with CONFIG_AMD_MEM_ENCRYPT

The sev_evict_cache() is guest-related code and should be guarded by
CONFIG_AMD_MEM_ENCRYPT, not CONFIG_KVM_AMD_SEV.

CONFIG_AMD_MEM_ENCRYPT=3Dy is required for a guest to run properly as an SEV-=
SNP
guest, but a guest kernel built with CONFIG_KVM_AMD_SEV=3Dn would get the stub
function of sev_evict_cache() instead of the version that performs the actual
eviction. Move the function declarations under the appropriate #ifdef.

Fixes: 7b306dfa326f ("x86/sev: Evict cache lines during SNP memory validation=
")
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Cc: stable@kernel.org # 6.16.x
Link: https://lore.kernel.org/r/70e38f2c4a549063de54052c9f64929705313526.1757=
708959.git.thomas.lendacky@amd.com
---
 arch/x86/include/asm/sev.h | 38 ++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 0223696..465b19f 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -562,6 +562,24 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
=20
 extern struct ghcb *boot_ghcb;
=20
+static inline void sev_evict_cache(void *va, int npages)
+{
+	volatile u8 val __always_unused;
+	u8 *bytes =3D va;
+	int page_idx;
+
+	/*
+	 * For SEV guests, a read from the first/last cache-lines of a 4K page
+	 * using the guest key is sufficient to cause a flush of all cache-lines
+	 * associated with that 4K page without incurring all the overhead of a
+	 * full CLFLUSH sequence.
+	 */
+	for (page_idx =3D 0; page_idx < npages; page_idx++) {
+		val =3D bytes[page_idx * PAGE_SIZE];
+		val =3D bytes[page_idx * PAGE_SIZE + PAGE_SIZE - 1];
+	}
+}
+
 #else	/* !CONFIG_AMD_MEM_ENCRYPT */
=20
 #define snp_vmpl 0
@@ -605,6 +623,7 @@ static inline int snp_send_guest_request(struct snp_msg_d=
esc *mdesc,
 static inline int snp_svsm_vtpm_send_command(u8 *buffer) { return -ENODEV; }
 static inline void __init snp_secure_tsc_prepare(void) { }
 static inline void __init snp_secure_tsc_init(void) { }
+static inline void sev_evict_cache(void *va, int npages) {}
=20
 #endif	/* CONFIG_AMD_MEM_ENCRYPT */
=20
@@ -619,24 +638,6 @@ int rmp_make_shared(u64 pfn, enum pg_level level);
 void snp_leak_pages(u64 pfn, unsigned int npages);
 void kdump_sev_callback(void);
 void snp_fixup_e820_tables(void);
-
-static inline void sev_evict_cache(void *va, int npages)
-{
-	volatile u8 val __always_unused;
-	u8 *bytes =3D va;
-	int page_idx;
-
-	/*
-	 * For SEV guests, a read from the first/last cache-lines of a 4K page
-	 * using the guest key is sufficient to cause a flush of all cache-lines
-	 * associated with that 4K page without incurring all the overhead of a
-	 * full CLFLUSH sequence.
-	 */
-	for (page_idx =3D 0; page_idx < npages; page_idx++) {
-		val =3D bytes[page_idx * PAGE_SIZE];
-		val =3D bytes[page_idx * PAGE_SIZE + PAGE_SIZE - 1];
-	}
-}
 #else
 static inline bool snp_probe_rmptable_info(void) { return false; }
 static inline int snp_rmptable_init(void) { return -ENOSYS; }
@@ -652,7 +653,6 @@ static inline int rmp_make_shared(u64 pfn, enum pg_level =
level) { return -ENODEV
 static inline void snp_leak_pages(u64 pfn, unsigned int npages) {}
 static inline void kdump_sev_callback(void) { }
 static inline void snp_fixup_e820_tables(void) {}
-static inline void sev_evict_cache(void *va, int npages) {}
 #endif
=20
 #endif

