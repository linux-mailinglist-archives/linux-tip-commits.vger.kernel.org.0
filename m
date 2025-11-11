Return-Path: <linux-tip-commits+bounces-7281-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4A7C4D6C1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4E2AD34629E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D97D256C8D;
	Tue, 11 Nov 2025 11:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bQMItmVs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wpeOiMpt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5FB357727;
	Tue, 11 Nov 2025 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861022; cv=none; b=F8p/2Y/iHYUZm9j6guzUlyNVHMbxThqwVoVbaIQK3gSyuxFj8Urlux71N7zuOBrKPOA5HtzRW7/t4Y4yrlLje3tO89YWp5kFr5wU2neQLFoJSzBaZujm6ZE0jYj6e+qYLyUNwvIz+RmcbBV2p5q5C+mR1mJo3vYPu6UvD+ivIEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861022; c=relaxed/simple;
	bh=9bxN0sT4Fh35BXeLguGma6OcF7HBh/mq3ZveFK9+PNo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=N4/HCi20eJsOK83udLp4nf9LiV9zojsQ+jIxIfmLzFecDE/eP2CdBOVs/mcD+cw+0AERQHnMlHFOzQ1a5JXZWZbHJ/qpRYaADhCLPgOaneqcHMZ0ezFuq+4VhAcEXqMMFBmeiESzgGZSEAVkh5tOex8oWUNYIsACpPj+JauY79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bQMItmVs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wpeOiMpt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:36:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861019;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XyCUK3xQsO3hpUXYOkJ3E5V07kZzyHH4on9YOZyf82s=;
	b=bQMItmVs4rxmv50QdvFEHzm2BsC0RjqrDonfxKqSEyPiSklGGag7vgOdwvbFk8z2SK7NTV
	q3BHE88x8hPDlUi2qGCccOVITbCzb8ILM1gIxpieoWsE20p2ZLIScEQfPrJuabDW7daMYa
	0Fb+wA4r14ESY50Ed2F/4TQXi2B9IeVr4UCzxicB2Q3c4i5EkqfoCWGYhxv+8sutn47ulR
	Xas2Oj1D2KdoAdw2HZ4+4CYJzYTdkjHjsvWMODBSyM0LQE7Ny+We3ghmmTHWXTGpXSY5Zl
	i+Yqux5l+WpxVtbAhhvsvBD9/Quc/tSIcyX8MGomUgOW/0hKXQ9GUH0pDBmhOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861019;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XyCUK3xQsO3hpUXYOkJ3E5V07kZzyHH4on9YOZyf82s=;
	b=wpeOiMptpwVMvJ8yxANInh4vCrOUhMvkjzwojoi5rjOvUbmdSmrbadyup7gl2miklZzKaF
	iTgVCJxn+VyO+IAg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Check PEBS dyn_constraints
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286101819.498.14615560018043981414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     02da693f6658b9f73b97fce3695358ef3f13d0d1
Gitweb:        https://git.kernel.org/tip/02da693f6658b9f73b97fce3695358ef3f1=
3d0d1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Nov 2025 14:50:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 07 Nov 2025 15:08:23 +01:00

perf/x86/intel: Check PEBS dyn_constraints

Handle the interaction between ("perf/x86/intel: Update dyn_constraint
base on PEBS event precise level") and ("perf/x86/intel: Add a check
for dynamic constraints").

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/intel/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 93780af..a421595 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5425,6 +5425,8 @@ enum dyn_constr_type {
 	DYN_CONSTR_BR_CNTR,
 	DYN_CONSTR_ACR_CNTR,
 	DYN_CONSTR_ACR_CAUSE,
+	DYN_CONSTR_PEBS,
+	DYN_CONSTR_PDIST,
=20
 	DYN_CONSTR_MAX,
 };
@@ -5434,6 +5436,8 @@ static const char * const dyn_constr_type_name[] =3D {
 	[DYN_CONSTR_BR_CNTR] =3D "a branch counter logging event",
 	[DYN_CONSTR_ACR_CNTR] =3D "an auto-counter reload event",
 	[DYN_CONSTR_ACR_CAUSE] =3D "an auto-counter reload cause event",
+	[DYN_CONSTR_PEBS] =3D "a PEBS event",
+	[DYN_CONSTR_PDIST] =3D "a PEBS PDIST event",
 };
=20
 static void __intel_pmu_check_dyn_constr(struct event_constraint *constr,
@@ -5538,6 +5542,14 @@ static void intel_pmu_check_dyn_constr(struct pmu *pmu,
 				continue;
 			mask =3D hybrid(pmu, acr_cause_mask64) & GENMASK_ULL(INTEL_PMC_MAX_GENERI=
C - 1, 0);
 			break;
+		case DYN_CONSTR_PEBS:
+			if (x86_pmu.arch_pebs)
+				mask =3D hybrid(pmu, arch_pebs_cap).counters;
+			break;
+		case DYN_CONSTR_PDIST:
+			if (x86_pmu.arch_pebs)
+				mask =3D hybrid(pmu, arch_pebs_cap).pdists;
+			break;
 		default:
 			pr_warn("Unsupported dynamic constraint type %d\n", i);
 		}

