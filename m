Return-Path: <linux-tip-commits+bounces-7876-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1827BD110E1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A9E73086349
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCBF4342512;
	Mon, 12 Jan 2026 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OBm6WQ5l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qOAWbnCv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0143341071;
	Mon, 12 Jan 2026 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204992; cv=none; b=E0oPuM3q7qeBKro9HJwpKEt2MY1xiaSUYIrxy7qvFc9vf6bQYofhBM0Bh+WlabPZLtxA6wA3BJpn+XQ5UpxPq1HlC5P2lQvqM3tra1yi/H+ZJxnaAOcYGTyVEF5G/OjJsnRA/KLwAlGn4OeRdkYtjBEi2mJMyly4V7ykJ7uce9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204992; c=relaxed/simple;
	bh=lWHforlVfP+vVzjbO16RN8nDymUmFZ+Tzs6Ygr6LfsE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MeDpB8jH6QVZZFvJ3H8TDmekQW16c03//JPu/oKYNmKMHGqEUwPcVD6dX1m6lNxE8Hw01YXvuLWnhEu1PkYKsttEKZYkbgCHq98jBHUoXxgTVjnbXu4vu7YlIDG+1+F4tgE0qRCTLFhAMpzJdAs4CJjkHKdQuBpQkouJNcKYBAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OBm6WQ5l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qOAWbnCv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:03:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768204989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BP96oj/weLQ8gOH87/ptxDgWh8bbOjU3E2J8Zmb/K74=;
	b=OBm6WQ5le5BpqiYr14IZ9B5DqeMTwsQsg1z6+SwppaSAaJRPK3sr0/+i5AKyQOZfELWUNv
	GVWXgayLIoP8bm5uWS1FNo5PUhCba8bCyOlcYkG89WpRijZc3eDcXIwOas8JoaCa/xuXqH
	T+OM74TPWKJm42kL48ycV871aBLP7W2LufzvFgM5BicOuY86t9zjdUGWVe9HsZzrGZwH9Y
	Wg/C7fMYpDGnpdkQSuBIc2B78VSErBgyCX0QWo4qCoACGKkMRH8EefJ+8ocZsblzQ3Ld9l
	NLV/ZsUl9pKsTc3v3NuYiwUyUhhr6t3BveOD4zvtnLY95GGTN4U1wvaKRsSwxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768204989;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BP96oj/weLQ8gOH87/ptxDgWh8bbOjU3E2J8Zmb/K74=;
	b=qOAWbnCvWYKGMs61JptBtoIrJb9O7AjXuR5+jLAEro2N9ol0edA7qrVE1GgDdeKn/tFw+h
	L+jJKQR9blB+4ECQ==
From: "tip-bot2 for Zide Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel/uncore: Support uncore constraint ranges
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251231224233.113839-10-zide.chen@intel.com>
References: <20251231224233.113839-10-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820498820.510.6644636354933024768.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     aacb0718fddfe7060576c82e47bbda559c2f2d0d
Gitweb:        https://git.kernel.org/tip/aacb0718fddfe7060576c82e47bbda559c2=
f2d0d
Author:        Zide Chen <zide.chen@intel.com>
AuthorDate:    Wed, 31 Dec 2025 14:42:26 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 06 Jan 2026 16:34:25 +01:00

perf/x86/intel/uncore: Support uncore constraint ranges

Add UNCORE_EVENT_CONSTRAINT_RANGE macro for uncore constraints,
similar to INTEL_EVENT_CONSTRAINT_RANGE, to reduce duplication when
defining consecutive uncore event constraints.

No functional change intended.

Suggested-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251231224233.113839-10-zide.chen@intel.com
---
 arch/x86/events/intel/uncore.c       |   2 +-
 arch/x86/events/intel/uncore.h       |   2 +-
 arch/x86/events/intel/uncore_snbep.c | 183 +++++---------------------
 3 files changed, 44 insertions(+), 143 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 25a678b..19ff8db 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -436,7 +436,7 @@ uncore_get_event_constraint(struct intel_uncore_box *box,=
 struct perf_event *eve
=20
 	if (type->constraints) {
 		for_each_event_constraint(c, type->constraints) {
-			if ((event->hw.config & c->cmask) =3D=3D c->code)
+			if (constraint_match(c, event->hw.config))
 				return c;
 		}
 	}
diff --git a/arch/x86/events/intel/uncore.h b/arch/x86/events/intel/uncore.h
index 55e3aeb..564cb26 100644
--- a/arch/x86/events/intel/uncore.h
+++ b/arch/x86/events/intel/uncore.h
@@ -33,6 +33,8 @@
 #define UNCORE_EXTRA_PCI_DEV_MAX	4
=20
 #define UNCORE_EVENT_CONSTRAINT(c, n) EVENT_CONSTRAINT(c, n, 0xff)
+#define UNCORE_EVENT_CONSTRAINT_RANGE(c, e, n)			\
+		EVENT_CONSTRAINT_RANGE(c, e, n, 0xff)
=20
 #define UNCORE_IGNORE_END		-1
=20
diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/unc=
ore_snbep.c
index cc8145e..eaeb4e9 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -836,76 +836,37 @@ static struct intel_uncore_ops snbep_uncore_pci_ops =3D=
 {
 static struct event_constraint snbep_uncore_cbox_constraints[] =3D {
 	UNCORE_EVENT_CONSTRAINT(0x01, 0x1),
 	UNCORE_EVENT_CONSTRAINT(0x02, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x04, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x05, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x04, 0x5, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x07, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x09, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x11, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x12, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x13, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x1b, 0xc),
-	UNCORE_EVENT_CONSTRAINT(0x1c, 0xc),
-	UNCORE_EVENT_CONSTRAINT(0x1d, 0xc),
-	UNCORE_EVENT_CONSTRAINT(0x1e, 0xc),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x12, 0x13, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x1b, 0x1e, 0xc),
 	UNCORE_EVENT_CONSTRAINT(0x1f, 0xe),
 	UNCORE_EVENT_CONSTRAINT(0x21, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x23, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x31, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x32, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x33, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x34, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x35, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x31, 0x35, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x36, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x37, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x38, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x39, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x37, 0x39, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x3b, 0x1),
 	EVENT_CONSTRAINT_END
 };
=20
 static struct event_constraint snbep_uncore_r2pcie_constraints[] =3D {
-	UNCORE_EVENT_CONSTRAINT(0x10, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x11, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x10, 0x11, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x12, 0x1),
 	UNCORE_EVENT_CONSTRAINT(0x23, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x24, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x25, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x26, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x32, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x33, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x34, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x24, 0x26, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x32, 0x34, 0x3),
 	EVENT_CONSTRAINT_END
 };
=20
 static struct event_constraint snbep_uncore_r3qpi_constraints[] =3D {
-	UNCORE_EVENT_CONSTRAINT(0x10, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x11, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x12, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x10, 0x12, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x13, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x20, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x21, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x22, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x23, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x24, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x25, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x26, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x28, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x29, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2a, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2b, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2c, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2e, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2f, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x30, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x31, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x32, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x33, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x34, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x36, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x37, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x38, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x39, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x20, 0x26, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x28, 0x34, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x36, 0x39, 0x3),
 	EVENT_CONSTRAINT_END
 };
=20
@@ -3034,24 +2995,15 @@ static struct intel_uncore_type hswep_uncore_qpi =3D {
 };
=20
 static struct event_constraint hswep_uncore_r2pcie_constraints[] =3D {
-	UNCORE_EVENT_CONSTRAINT(0x10, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x11, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x10, 0x11, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x13, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x23, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x24, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x25, 0x1),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x23, 0x25, 0x1),
 	UNCORE_EVENT_CONSTRAINT(0x26, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x27, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x28, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x29, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x28, 0x29, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x2a, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x2b, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2c, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x32, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x33, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x34, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x35, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x2b, 0x2d, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x32, 0x35, 0x3),
 	EVENT_CONSTRAINT_END
 };
=20
@@ -3066,38 +3018,17 @@ static struct intel_uncore_type hswep_uncore_r2pcie =
=3D {
=20
 static struct event_constraint hswep_uncore_r3qpi_constraints[] =3D {
 	UNCORE_EVENT_CONSTRAINT(0x01, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x07, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x08, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x09, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x0a, 0x7),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x7, 0x0a, 0x7),
 	UNCORE_EVENT_CONSTRAINT(0x0e, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x10, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x11, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x12, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x10, 0x12, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x13, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x14, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x15, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x1f, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x20, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x21, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x22, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x23, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x25, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x26, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x28, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x29, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2c, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2e, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2f, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x31, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x32, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x33, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x34, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x36, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x37, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x38, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x39, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x14, 0x15, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x1f, 0x23, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x25, 0x26, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x28, 0x29, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x2c, 0x2f, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x31, 0x34, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x36, 0x39, 0x3),
 	EVENT_CONSTRAINT_END
 };
=20
@@ -3371,8 +3302,7 @@ static struct event_constraint bdx_uncore_r2pcie_constr=
aints[] =3D {
 	UNCORE_EVENT_CONSTRAINT(0x25, 0x1),
 	UNCORE_EVENT_CONSTRAINT(0x26, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x28, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2c, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x2c, 0x2d, 0x3),
 	EVENT_CONSTRAINT_END
 };
=20
@@ -3387,35 +3317,18 @@ static struct intel_uncore_type bdx_uncore_r2pcie =3D=
 {
=20
 static struct event_constraint bdx_uncore_r3qpi_constraints[] =3D {
 	UNCORE_EVENT_CONSTRAINT(0x01, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x07, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x08, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x09, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x0a, 0x7),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x07, 0x0a, 0x7),
 	UNCORE_EVENT_CONSTRAINT(0x0e, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x10, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x11, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x10, 0x11, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x13, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x14, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x15, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x1f, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x20, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x21, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x22, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x23, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x14, 0x15, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x1f, 0x23, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x25, 0x3),
 	UNCORE_EVENT_CONSTRAINT(0x26, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x28, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x29, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2c, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2d, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2e, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x2f, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x33, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x34, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x36, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x37, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x38, 0x3),
-	UNCORE_EVENT_CONSTRAINT(0x39, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x28, 0x29, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x2c, 0x2f, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x33, 0x34, 0x3),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x36, 0x39, 0x3),
 	EVENT_CONSTRAINT_END
 };
=20
@@ -3722,8 +3635,7 @@ static struct event_constraint skx_uncore_iio_constrain=
ts[] =3D {
 	UNCORE_EVENT_CONSTRAINT(0x95, 0xc),
 	UNCORE_EVENT_CONSTRAINT(0xc0, 0xc),
 	UNCORE_EVENT_CONSTRAINT(0xc5, 0xc),
-	UNCORE_EVENT_CONSTRAINT(0xd4, 0xc),
-	UNCORE_EVENT_CONSTRAINT(0xd5, 0xc),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0xd4, 0xd5, 0xc),
 	EVENT_CONSTRAINT_END
 };
=20
@@ -4479,14 +4391,9 @@ static struct intel_uncore_type skx_uncore_m2pcie =3D {
 };
=20
 static struct event_constraint skx_uncore_m3upi_constraints[] =3D {
-	UNCORE_EVENT_CONSTRAINT(0x1d, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x1e, 0x1),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x1d, 0x1e, 0x1),
 	UNCORE_EVENT_CONSTRAINT(0x40, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x4e, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x4f, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x50, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x51, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x52, 0x7),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x4e, 0x52, 0x7),
 	EVENT_CONSTRAINT_END
 };
=20
@@ -5652,14 +5559,9 @@ static struct intel_uncore_type icx_uncore_upi =3D {
 };
=20
 static struct event_constraint icx_uncore_m3upi_constraints[] =3D {
-	UNCORE_EVENT_CONSTRAINT(0x1c, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x1d, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x1e, 0x1),
-	UNCORE_EVENT_CONSTRAINT(0x1f, 0x1),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x1c, 0x1f, 0x1),
 	UNCORE_EVENT_CONSTRAINT(0x40, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x4e, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x4f, 0x7),
-	UNCORE_EVENT_CONSTRAINT(0x50, 0x7),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x4e, 0x50, 0x7),
 	EVENT_CONSTRAINT_END
 };
=20
@@ -6142,10 +6044,7 @@ static struct intel_uncore_ops spr_uncore_mmio_offs8_o=
ps =3D {
 static struct event_constraint spr_uncore_cxlcm_constraints[] =3D {
 	UNCORE_EVENT_CONSTRAINT(0x02, 0x0f),
 	UNCORE_EVENT_CONSTRAINT(0x05, 0x0f),
-	UNCORE_EVENT_CONSTRAINT(0x40, 0xf0),
-	UNCORE_EVENT_CONSTRAINT(0x41, 0xf0),
-	UNCORE_EVENT_CONSTRAINT(0x42, 0xf0),
-	UNCORE_EVENT_CONSTRAINT(0x43, 0xf0),
+	UNCORE_EVENT_CONSTRAINT_RANGE(0x40, 0x43, 0xf0),
 	UNCORE_EVENT_CONSTRAINT(0x4b, 0xf0),
 	UNCORE_EVENT_CONSTRAINT(0x52, 0xf0),
 	EVENT_CONSTRAINT_END

