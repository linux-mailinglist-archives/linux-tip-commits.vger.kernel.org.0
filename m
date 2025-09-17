Return-Path: <linux-tip-commits+bounces-6666-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8975FB7F495
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 15:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B153B8849
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 09:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CD030C63A;
	Wed, 17 Sep 2025 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K29dt8VN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+MikVR7B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261C830AAAD;
	Wed, 17 Sep 2025 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758101271; cv=none; b=bodonwaxQYes39S8DAJivFbwF9Y9VU2EddLztXhE3KZqv7NAt5UNjzcEFyFqJqUIEmRvh4c/67AaS7fYQpEttFzTpOcvgqq8xz1QgnE9BcpRrW2EfVMKg4VdBJuhY0SFlfywp9FsLfnpUrGFi8k/yVrE2YWc9muaGJ10O2OA1Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758101271; c=relaxed/simple;
	bh=goJMI34tzxWP2he/Wfn0ACo+8jD4IaUHvALsIdlZRwg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=XajYU2NIuvIgKTbDQWIIu8lamqJRIHn9gG8yGxJVnjQMHhYtA+8lC+G8I3KluCdZIrrSysTMjz9ovZhU+dbSkeaXrshqILvMBqVS0bmHfNq/cwZDPuzbdKxDPF22fSLXr6nElzN4t1EaL+QJzKuM4RMPeVU5rFcYS+aAjksg374=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K29dt8VN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+MikVR7B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 09:27:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758101268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8Rsy7XZNrAxGiuK63PBLFyhJPuBAdWNmUb5pbPkTv+s=;
	b=K29dt8VNJCBvnKx426j0ljAdzFuoh4L19ohQwxHWC/6pvKgU15Iwk7SA3NpmCU1jTHTizr
	kW0M+IXAGQ5f3jWCiJMmkQwxau+hOeFQe5qcJFG/m6/aXoxRm4i6cylYHqQperL/eZ2Wfw
	E04SlcUem/TYpoLLhf8Mzdmf6NIo8I3UwE62RjNaNySElY4spToGRsgQ1ks3eCayY92DdB
	WOo5RA6QyO4QqWmqYvoC6gl0AehuQdufB6yUrtUUcE6+ziqFW0zErCqeJLI8S4p3Z2GK1V
	0xJIXafhe1BI3XNNiXtb1l+fdNjt5G/+IVKXV/vRa/iHp/tBdXQJzjDnN9Udsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758101268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=8Rsy7XZNrAxGiuK63PBLFyhJPuBAdWNmUb5pbPkTv+s=;
	b=+MikVR7Bx2llKrgPYBsbbTnIMYS6bTNKZiTBTiSuAVWukSaJZT1beIUtm+Cx5693Y6eWQM
	7+UllSL8qZoS0cCw==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/topology: Check for X86_FEATURE_XTOPOLOGY
 instead of passing has_xtopology
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175810126720.709179.9990618507549218228.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d691c5f87f344a448b1a522284fa314e2bb403e2
Gitweb:        https://git.kernel.org/tip/d691c5f87f344a448b1a522284fa314e2bb=
403e2
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Mon, 01 Sep 2025 17:04:16=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Sep 2025 11:23:40 +02:00

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
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

