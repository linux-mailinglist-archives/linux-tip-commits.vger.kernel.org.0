Return-Path: <linux-tip-commits+bounces-6641-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC446B5935E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 12:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E6AF4E1885
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Sep 2025 10:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9B2303A13;
	Tue, 16 Sep 2025 10:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hn6P2e22";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WWg6UOqP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AEF2F7AA5;
	Tue, 16 Sep 2025 10:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018101; cv=none; b=efMj5i6G0XfTNNNaHgPAq1FIcEROloWtPZfkNNlK8oHYNvfedPjT7oJxzFMG4PhC/2k1HDpOtjy6JfdKF4wRNCJk12OchAb/WebrxSSZm/p1Bro8pPH0m6hk5+Cgmoae/Nip0UfLN8ZJ2Z/Ra6LYS3zq8CxPtoYIdkYGWyCZzG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018101; c=relaxed/simple;
	bh=5M7EmowOZ3wzbnpqTW13qrczF6oB+V9lEWJCxjTC/qY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=b8ymUQ/43jGcm9u0qQ7GU/ns91UxX+yS4CS3e7xXrL3qc953MNDogESr8p+/Do2Wki/BlxfHTXLapOFuDQO2is2yd3MPBJ3i6NbtPInuuPSztgtmPrfABUqlEe6VdipxMhiIB1ubZWA6Cspt/Xp9Ly7yTQSxrWoXOEhbbhVAiSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hn6P2e22; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WWg6UOqP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Sep 2025 10:21:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758018097;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5DdiNgO0pcX5UDbHvid5w5m8Pcidfg2BC7g7gxbny+s=;
	b=hn6P2e22rHPTbtxNe0+hPMXtBt+p6P0ed5G7glmvoyMeseQyYesr8x+D4rouSxJTrFiGZx
	yajhL+OucjncPA2PgZ/oNCRkT9VcV21R/FZB2q9k5+yL9WdtNyAatVUtUv4HRGaHvxEzwA
	Ys5GuycVI5ImwDwXKIWdQrYdcQ5ek9ImX3MuVNPWMDUZgajeBtswnwrVcQjOjeouyCvm5F
	nVQmCzwR9RPauIcL5+H8v8nZk61UaW3p0/Hel/CyntTrznGnOAlmktJhroO/dI07n0hfGL
	1/6T+/I9RYYqseKA4c+cRYTTz6GGA/rnVsfwPVavEUXfBBzxoCPk5A1FT2Tfsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758018097;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5DdiNgO0pcX5UDbHvid5w5m8Pcidfg2BC7g7gxbny+s=;
	b=WWg6UOqPXJxDIzUUSuY1gKMDDZ9AyEzl5Ig/qn5Itv0XhYWP4A4waFZMBdwAtW17kFaAHT
	4T8Sr6A4GNLyDZDw==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/topology: Check for X86_FEATURE_XTOPOLOGY
 instead of passing has_xtopology
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175801809631.709179.14372885195494312013.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     38ebac2d21c8895720ac2ddf28b4623ac6ff9dd6
Gitweb:        https://git.kernel.org/tip/38ebac2d21c8895720ac2ddf28b4623ac6f=
f9dd6
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Mon, 01 Sep 2025 17:04:16=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 14:28:34 +02:00

x86/cpu/topology: Check for X86_FEATURE_XTOPOLOGY instead of passing has_xtop=
ology

cpu_parse_topology_ext() sets X86_FEATURE_XTOPOLOGY before returning
true if any of the XTOPOLOGY leaf (0x80000026 / 0xb) could be parsed
successfully.

Instead of storing and passing around this return value using
"has_xtopology" in parse_topology_amd(), check for X86_FEATURE_XTOPOLOGY
directly in parse_8000_001e() to simplify the flow.

No functional changes intended.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250901170418.4314-1-kprateek.nayak@amd.com
---
 arch/x86/kernel/cpu/topology_amd.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topolog=
y_amd.c
index c79ebbb..7ebd4a1 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -59,7 +59,7 @@ static void store_node(struct topo_scan *tscan, u16 nr_node=
s, u16 node_id)
 	tscan->amd_node_id =3D node_id;
 }
=20
-static bool parse_8000_001e(struct topo_scan *tscan, bool has_topoext)
+static bool parse_8000_001e(struct topo_scan *tscan)
 {
 	struct {
 		// eax
@@ -85,7 +85,7 @@ static bool parse_8000_001e(struct topo_scan *tscan, bool h=
as_topoext)
 	 * If leaf 0xb/0x26 is available, then the APIC ID and the domain
 	 * shifts are set already.
 	 */
-	if (!has_topoext) {
+	if (!cpu_feature_enabled(X86_FEATURE_XTOPOLOGY)) {
 		tscan->c->topo.initial_apicid =3D leaf.ext_apic_id;
=20
 		/*
@@ -175,30 +175,27 @@ static void topoext_fixup(struct topo_scan *tscan)
=20
 static void parse_topology_amd(struct topo_scan *tscan)
 {
+	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
+		tscan->c->topo.cpu_type =3D cpuid_ebx(0x80000026);
+
 	/*
 	 * Try to get SMT, CORE, TILE, and DIE shifts from extended
 	 * CPUID leaf 0x8000_0026 on supported processors first. If
 	 * extended CPUID leaf 0x8000_0026 is not supported, try to
 	 * get SMT and CORE shift from leaf 0xb. If either leaf is
 	 * available, cpu_parse_topology_ext() will return true.
-	 */
-	bool has_xtopology =3D cpu_parse_topology_ext(tscan);
-
-	if (cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
-		tscan->c->topo.cpu_type =3D cpuid_ebx(0x80000026);
-
-	/*
+	 *
 	 * If XTOPOLOGY leaves (0x26/0xb) are not available, try to
 	 * get the CORE shift from leaf 0x8000_0008 first.
 	 */
-	if (!has_xtopology && !parse_8000_0008(tscan))
+	if (!cpu_parse_topology_ext(tscan) && !parse_8000_0008(tscan))
 		return;
=20
 	/*
 	 * Prefer leaf 0x8000001e if available to get the SMT shift and
 	 * the initial APIC ID if XTOPOLOGY leaves are not available.
 	 */
-	if (parse_8000_001e(tscan, has_xtopology))
+	if (parse_8000_001e(tscan))
 		return;
=20
 	/* Try the NODEID MSR */

