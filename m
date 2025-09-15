Return-Path: <linux-tip-commits+bounces-6613-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98462B57821
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 13:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CAE71A2543D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Sep 2025 11:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7B330149B;
	Mon, 15 Sep 2025 11:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ide9Cs7u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MEsEblYN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AAD301033;
	Mon, 15 Sep 2025 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935659; cv=none; b=qRYjIWLn11gEx6OTMa3BUDK57LqeN0MvmK2+C6suvi1JM1rjiNVQ8chOBtYgIrDKX2VoemDqRqpWwU8aNOUFqqRMsX3/rPU4shVPUgNp6MnTLyShj1gDd1Os4rz/90h2UljSTeO2PFFNri9a4OMHIZlKxPx913cLJ9u0koX640A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935659; c=relaxed/simple;
	bh=H9hcdbpw4X8TDxl8v4ao+sqj2UfAOzHdBkA0IFJAvrQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AaL6z63ZGLY+qYN+qkwaALv7+qspPmII7FuJ379eXfwWmYLKdeXUgVsVCy51uXgv0Mtw7Te0JBv+BGFnKTjZKJZxNY9dgvuRdQv1J5jsyjfNRgZ9N1Odx01d6dT77PZcpFkDmE+E19bglyPxSCRH5V6FY7GinpYBbBoGqPr1urY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ide9Cs7u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MEsEblYN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 11:27:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757935653;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TsKzykXNy7oVl0ACYXwT9d/PDA91mTC0+fpFBQGvWbA=;
	b=Ide9Cs7uAoQb+h0jNoJWycLroJ2lI8iAK9HXZNkdu6eQqCVti8gwzgRErbfeWGh30orwmE
	Esf9QbLBBUiptpYF54yu5SIZ73x28KbhQ9F6SLIv4jq9uPMp4mKfjbIGyfGEN/GVxQfrHN
	wwAaSzWyMt32JVfhtJh0m5L5WtxUbjulqvJ1JJwmRCIQgUTUEgfZq62LhsxeQlurFke2Ml
	O4nqyizWx5zGqfLzB8Ay+BQBe4nJLCS6tulQrGVjTDQPtq9o46MxLrZwAMuQ3OjXBpClY7
	vpr8insmm3lunYeciKgTYHuD7rFBSuqxZOuUq8P+TN0efx+REsg5K2TOkC1iNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757935653;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TsKzykXNy7oVl0ACYXwT9d/PDA91mTC0+fpFBQGvWbA=;
	b=MEsEblYNRl8YoMueJ/ZWl4rp6emP68jsDfbBLLZUNtmhHcPUtl21drV3O8mrvoHo8PVa3u
	5T9r56iEE4Hb9YCA==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Implement resctrl_arch_reset_cntr() and
 resctrl_arch_cntr_read()
Cc: Babu Moger <babu.moger@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <8ef30aebd36972ea63f422f28b465fc4b2544fa4.1757108044.git.babu.moger@amd.com>
References:
 <8ef30aebd36972ea63f422f28b465fc4b2544fa4.1757108044.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175793565230.709179.8877435059894464441.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     2a65b72c1603a74f35228acbb8de2ecff9c13efe
Gitweb:        https://git.kernel.org/tip/2a65b72c1603a74f35228acbb8de2ecff9c=
13efe
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 05 Sep 2025 16:34:21 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 15 Sep 2025 12:30:22 +02:00

x86/resctrl: Implement resctrl_arch_reset_cntr() and resctrl_arch_cntr_read()

System software reads resctrl event data for a particular resource by writing
the RMID and Event Identifier (EvtID) to the QM_EVTSEL register and then
reading the event data from the QM_CTR register.

In ABMC mode, the event data of a specific counter ID is read by setting the
following fields: QM_EVTSEL.ExtendedEvtID =3D 1, QM_EVTSEL.EvtID =3D L3CacheA=
BMC
(=3D1) and setting QM_EVTSEL.RMID to the desired counter ID.  Reading the QM_=
CTR
then returns the contents of the specified counter ID.  RMID_VAL_ERROR bit is
set if the counter configuration is invalid, or if an invalid counter ID is
set in the QM_EVTSEL.RMID field.  RMID_VAL_UNAVAIL bit is set if the counter
data is unavailable.

Introduce resctrl_arch_reset_cntr() and resctrl_arch_cntr_read() to reset and
read event data for a specific counter.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/cover.1757108044.git.babu.moger@amd.com
---
 arch/x86/kernel/cpu/resctrl/internal.h |  6 ++-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 69 +++++++++++++++++++++++++-
 2 files changed, 75 insertions(+)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/res=
ctrl/internal.h
index 0444fea..e5edddb 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -40,6 +40,12 @@ struct arch_mbm_state {
 /* Setting bit 0 in L3_QOS_EXT_CFG enables the ABMC feature. */
 #define ABMC_ENABLE_BIT			0
=20
+/*
+ * Qos Event Identifiers.
+ */
+#define ABMC_EXTENDED_EVT_ID		BIT(31)
+#define ABMC_EVT_ID			BIT(0)
+
 /**
  * struct rdt_hw_ctrl_domain - Arch private attributes of a set of CPUs that=
 share
  *			       a resource for a control function
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index 1f77fd5..0b3c199 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -259,6 +259,75 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struc=
t rdt_mon_domain *d,
 	return 0;
 }
=20
+static int __cntr_id_read(u32 cntr_id, u64 *val)
+{
+	u64 msr_val;
+
+	/*
+	 * QM_EVTSEL Register definition:
+	 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+	 * Bits    Mnemonic        Description
+	 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+	 * 63:44   --              Reserved
+	 * 43:32   RMID            RMID or counter ID in ABMC mode
+	 *                         when reading an MBM event
+	 * 31      ExtendedEvtID   Extended Event Identifier
+	 * 30:8    --              Reserved
+	 * 7:0     EvtID           Event Identifier
+	 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+	 * The contents of a specific counter can be read by setting the
+	 * following fields in QM_EVTSEL.ExtendedEvtID(=3D1) and
+	 * QM_EVTSEL.EvtID =3D L3CacheABMC (=3D1) and setting QM_EVTSEL.RMID
+	 * to the desired counter ID. Reading the QM_CTR then returns the
+	 * contents of the specified counter. The RMID_VAL_ERROR bit is set
+	 * if the counter configuration is invalid, or if an invalid counter
+	 * ID is set in the QM_EVTSEL.RMID field.  The RMID_VAL_UNAVAIL bit
+	 * is set if the counter data is unavailable.
+	 */
+	wrmsr(MSR_IA32_QM_EVTSEL, ABMC_EXTENDED_EVT_ID | ABMC_EVT_ID, cntr_id);
+	rdmsrl(MSR_IA32_QM_CTR, msr_val);
+
+	if (msr_val & RMID_VAL_ERROR)
+		return -EIO;
+	if (msr_val & RMID_VAL_UNAVAIL)
+		return -EINVAL;
+
+	*val =3D msr_val;
+	return 0;
+}
+
+void resctrl_arch_reset_cntr(struct rdt_resource *r, struct rdt_mon_domain *=
d,
+			     u32 unused, u32 rmid, int cntr_id,
+			     enum resctrl_event_id eventid)
+{
+	struct rdt_hw_mon_domain *hw_dom =3D resctrl_to_arch_mon_dom(d);
+	struct arch_mbm_state *am;
+
+	am =3D get_arch_mbm_state(hw_dom, rmid, eventid);
+	if (am) {
+		memset(am, 0, sizeof(*am));
+
+		/* Record any initial, non-zero count value. */
+		__cntr_id_read(cntr_id, &am->prev_msr);
+	}
+}
+
+int resctrl_arch_cntr_read(struct rdt_resource *r, struct rdt_mon_domain *d,
+			   u32 unused, u32 rmid, int cntr_id,
+			   enum resctrl_event_id eventid, u64 *val)
+{
+	u64 msr_val;
+	int ret;
+
+	ret =3D __cntr_id_read(cntr_id, &msr_val);
+	if (ret)
+		return ret;
+
+	*val =3D get_corrected_val(r, d, rmid, eventid, msr_val);
+
+	return 0;
+}
+
 /*
  * The power-on reset value of MSR_RMID_SNC_CONFIG is 0x1
  * which indicates that RMIDs are configured in legacy mode.

