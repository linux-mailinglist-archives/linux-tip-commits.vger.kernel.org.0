Return-Path: <linux-tip-commits+bounces-6614-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B25B57824
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFE8204395
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D8A62FE587;
	Mon, 15 Sep 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nFLGJkJU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VsD8VUBq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B2D301034;
	Mon, 15 Sep 2025 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935659; cv=none; b=bVHA921Y+tOH6vPgP8BGttz0riOjoiSJelajAPcWRbXoyHAxmA/7NXTqgZVt3l+uQ+Xw5/u/eKIlD7k3nphMZrAID6kZg9oD1Fs+u7XznrNtDTHwb9BeZZsH7nxXsftEDizT33ZdLxLtBxKVw3oTm7bu3/iznt3BOu1tltgEHv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935659; c=relaxed/simple;
	bh=uwqZR7CIbvcwkv9IcshtFNwDkVFA6Xf3F7udBIW92Dk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rXgusuBXbIKdwvY0m/6gObZPAFN5+uR+09lYavOj/uMPWP/7SBkYkKIcj5fBxtTgtciFVnmCx8BRntoREQAy6PD0sZx4m68m7PgWFtCzbZH6SxjEuUCvbF7XEb1aW2sGD5EGQyZOX2Zi1WtfpR99Qz9tGTR5Au0E+g6I94idtm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nFLGJkJU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VsD8VUBq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935654;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ErRxWf5nNk7DUQLiNNl4CyccvHf9PSQMvl4x8J/Gb00=;
	b=nFLGJkJUKDYisvmW59FORRtju1iaEvIDrH2zaf4p6OSImh66wiMXFnhmU6vao8JnL3Nr1q
	qxlfd4vmYRuvhdPJ3HjJknR7uRRRzClIYGIzEYHX+oD8n7GZr3iXo8hUwud8BDCrxCDPCY
	uKqNE0qyG6pL5eDDpczqR5oRFQuSzEIj6g6eDXXMR837p4ZBljNiPQK5+/VbDfDiOETeEA
	9CgCdBdLb1WvW6KtygqFJDq/5r7EikCow4tMtyBN+gtGWEKAX6EcnfxBUsEC6RVGbKGWGC
	vD0DbTwJmccoRBccj8eIEPDwGKai/n/nPHvsU75jPRV63wOZPJrTHwUxgn897Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935654;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ErRxWf5nNk7DUQLiNNl4CyccvHf9PSQMvl4x8J/Gb00=;
	b=VsD8VUBqRJZ+K/pLnD2KFT6EuSe0l+wRZlcxeqZRh6OnX2KZmLNHbMGKo9wYuaFNAQV3q5
	qoJ6V/A7za6IMCBg==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Refactor resctrl_arch_rmid_read()
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <42b6175169d36c2816cbdb3f31e53a98210ff501.1757108044.git.babu.moger@amd.com>
References:
 <42b6175169d36c2816cbdb3f31e53a98210ff501.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793565346.709179.5878050433454885901.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     7c9ac605e202c4668e441fc8146a993577131ca1
Gitweb:        https://git.kernel.org/tip/7c9ac605e202c4668e441fc8146a9935771=
31ca1
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:20 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:28:21 +02:00

x86/resctrl: Refactor resctrl_arch_rmid_read()

resctrl_arch_rmid_read() adjusts the value obtained from MSR_IA32_QM_CTR to
account for the overflow for MBM events and apply counter scaling for all the
events. This logic is common to both reading an RMID and reading a hardware
counter directly.

Refactor the hardware value adjustment logic into get_corrected_val() to
prepare for support of reading a hardware counter.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 38 +++++++++++++++-----------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index ed295a6..1f77fd5 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -217,24 +217,13 @@ static u64 mbm_overflow_count(u64 prev_msr, u64 cur_msr=
, unsigned int width)
 	return chunks >> shift;
 }
=20
-int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
-			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
-			   u64 *val, void *ignored)
+static u64 get_corrected_val(struct rdt_resource *r, struct rdt_mon_domain *=
d,
+			     u32 rmid, enum resctrl_event_id eventid, u64 msr_val)
 {
 	struct rdt_hw_mon_domain *hw_dom =3D resctrl_to_arch_mon_dom(d);
 	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);
-	int cpu =3D cpumask_any(&d->hdr.cpu_mask);
 	struct arch_mbm_state *am;
-	u64 msr_val, chunks;
-	u32 prmid;
-	int ret;
-
-	resctrl_arch_rmid_read_context_check();
-
-	prmid =3D logical_rmid_to_physical_rmid(cpu, rmid);
-	ret =3D __rmid_read_phys(prmid, eventid, &msr_val);
-	if (ret)
-		return ret;
+	u64 chunks;
=20
 	am =3D get_arch_mbm_state(hw_dom, rmid, eventid);
 	if (am) {
@@ -246,7 +235,26 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struc=
t rdt_mon_domain *d,
 		chunks =3D msr_val;
 	}
=20
-	*val =3D chunks * hw_res->mon_scale;
+	return chunks * hw_res->mon_scale;
+}
+
+int resctrl_arch_rmid_read(struct rdt_resource *r, struct rdt_mon_domain *d,
+			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
+			   u64 *val, void *ignored)
+{
+	int cpu =3D cpumask_any(&d->hdr.cpu_mask);
+	u64 msr_val;
+	u32 prmid;
+	int ret;
+
+	resctrl_arch_rmid_read_context_check();
+
+	prmid =3D logical_rmid_to_physical_rmid(cpu, rmid);
+	ret =3D __rmid_read_phys(prmid, eventid, &msr_val);
+	if (ret)
+		return ret;
+
+	*val =3D get_corrected_val(r, d, rmid, eventid, msr_val);
=20
 	return 0;
 }

