Return-Path: <linux-tip-commits+bounces-7885-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA1DD11114
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A148F3043A48
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF75340D82;
	Mon, 12 Jan 2026 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SilJRI06";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tcfBLqBK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58643451C6;
	Mon, 12 Jan 2026 08:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205008; cv=none; b=go1MLpBFObS3wnEhOINQlinjXR1jdKbw81u5XpXE00yYEsFYZKTH1AtGdS7wQigmlbNbZjCdxl4l8mI2xeKqBA2aBgIF5tPwlXAVI2DXkkK+DZa/nEK70P4fiXFzm9/DzaiD2T3awlIFh9aZbOfmKR8ac/g/YTYQmktT5ZEEaok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205008; c=relaxed/simple;
	bh=VoLenfLUx95hXgmt/scPIIzi5xz+M6wsvyPxzEoWLu4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ut6ScbIgWg5ww0J+NqbWMT1l9U2kpHe5jfr/Ttn4v87430K8hpsPLajrGV/KOtQMt2aw18g5245fk3ohp25saWsQeUpelaHutTpXyXQ23kujDComj/hUQJA6O3D8ajMTnb2Aj7JH684Yg9ZPStox/wLwvciQV8VWIA+m32dZGqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SilJRI06; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tcfBLqBK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:03:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768204999;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTRWfOgdbH9PWJ3WZf6+TfC6cmPYYZfDD0hFv/IZkww=;
	b=SilJRI06+Ou6rKcLgsMGhWY2kE4ICWv99FEz8r9XX41XiBYQyg+utTpFCXGm3kWSi+BR89
	7iXu0vHw6ATGrzzobY62wSckHYpgx6sXiFxyOpcWiBwgEz6eFHDpxYY5xAJiaViognVtL3
	sPGvlHzNiLFZm9Mn0QSpHhCs96SbGhtA0bDxi+hmysDem5aHKiPIM94pvh6vJ7q3oN79uA
	x7KWSWy09HT9OrG0wV98CADvf4ZdEv4wQb8fDABT0qqUHIqRjRVxpxOBLSZH5vCs5jAi7I
	gstXHyGnXeOiz78yw/3EE14Mbjyrye/RhVP602syZ7/1jgIRhz6jQuFKjmZMbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768204999;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTRWfOgdbH9PWJ3WZf6+TfC6cmPYYZfDD0hFv/IZkww=;
	b=tcfBLqBKlvOqKVfoLQd/hwGUUAplmhuDas8yLSrjwdYgfpU5NVHGHS0NbvXiiz1mo4bvCX
	6w52K95UW2UkcTCw==
From: "tip-bot2 for Greg Kroah-Hartman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/uncore: clean up const mismatch
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <2025121741-headstand-stratus-f5eb@gregkh>
References: <2025121741-headstand-stratus-f5eb@gregkh>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820499824.510.16331640362946890724.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     632d89b030f1dac8d91875cd56a08adededba349
Gitweb:        https://git.kernel.org/tip/632d89b030f1dac8d91875cd56a08adeded=
ba349
Author:        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
AuthorDate:    Wed, 17 Dec 2025 13:42:41 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jan 2026 16:34:23 +01:00

perf/x86/uncore: clean up const mismatch

In some cmp functions, a const pointer is cast out to a non-const
pointer by using container_of() which is not correct.  Fix this up by
properly marking the pointers as const, which preserves the correct
type of the pointer passed into the functions.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/2025121741-headstand-stratus-f5eb@gregkh
---
 arch/x86/events/intel/uncore_discovery.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/uncore_discovery.c b/arch/x86/events/intel=
/uncore_discovery.c
index 7d57ce7..330bca2 100644
--- a/arch/x86/events/intel/uncore_discovery.c
+++ b/arch/x86/events/intel/uncore_discovery.c
@@ -52,7 +52,7 @@ static int get_device_die_id(struct pci_dev *dev)
=20
 static inline int __type_cmp(const void *key, const struct rb_node *b)
 {
-	struct intel_uncore_discovery_type *type_b =3D __node_2_type(b);
+	const struct intel_uncore_discovery_type *type_b =3D __node_2_type(b);
 	const u16 *type_id =3D key;
=20
 	if (type_b->type > *type_id)
@@ -115,7 +115,7 @@ get_uncore_discovery_type(struct uncore_unit_discovery *u=
nit)
=20
 static inline int pmu_idx_cmp(const void *key, const struct rb_node *b)
 {
-	struct intel_uncore_discovery_unit *unit;
+	const struct intel_uncore_discovery_unit *unit;
 	const unsigned int *id =3D key;
=20
 	unit =3D rb_entry(b, struct intel_uncore_discovery_unit, node);
@@ -173,7 +173,7 @@ int intel_uncore_find_discovery_unit_id(struct rb_root *u=
nits, int die,
=20
 static inline bool unit_less(struct rb_node *a, const struct rb_node *b)
 {
-	struct intel_uncore_discovery_unit *a_node, *b_node;
+	const struct intel_uncore_discovery_unit *a_node, *b_node;
=20
 	a_node =3D rb_entry(a, struct intel_uncore_discovery_unit, node);
 	b_node =3D rb_entry(b, struct intel_uncore_discovery_unit, node);

