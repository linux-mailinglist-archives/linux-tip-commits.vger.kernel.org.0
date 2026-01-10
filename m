Return-Path: <linux-tip-commits+bounces-7840-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF160D0DC49
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 344D230519C1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070811B4F1F;
	Sat, 10 Jan 2026 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CQACIMqU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DHqdZXP7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E9927B34E;
	Sat, 10 Jan 2026 19:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074363; cv=none; b=HyYxe0U9UrG4MmPXH1XgsXcZzw80xiszVl792ZqV+RZa/nD53WVJOfz9oxqhGsJDcXSmWwzyb2ye4HyBUhvDQMeyXfpGoEP0j9xPXMdr7mnkeES96G5vyvhsP2GIM9sFDtT2ylEVrlI4lx0n3MDgvjqNr8KJkzJRK6UKCIgStq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074363; c=relaxed/simple;
	bh=/LAOV+Ff61CSvfyrY5L2KmgVLcabWZipv04s05ZJCfo=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=rwnTdG6KZPv/MnYRdpY9Bul5B6Xot34ItFMBG1v+KF1g3EH0pvUn5htUB8h+L6nqTsG/VQ3qQUMJrr0NVMSGiFJV1aLcZ3WdGVMB7eoquBCM+zz2M2EpJ+XH8M2WtxhIGMGKIyrUqhBLOquEHWj0G5G6LPZrynMXZIOIm2BkbW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CQACIMqU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DHqdZXP7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:45:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074357;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=TPEbHqe1uPycFyttd3bzZoDC9rFLGxIgSg4Vq1EaLF0=;
	b=CQACIMqUkvy4Y/xi6D4exgWSWb7n2ZSP1PrVooCJ9syrWHY6jT2viR0iumFxK0Sm+VePjD
	fl+cTmQLZc/1MYj7EEYn91wlZmUW2XXF3M54WrWtAUdacuSqR3nJkmKjHu3m1iS8oKqhbc
	J6MrbDB5achAY/qwYfbHwiJtTdw5O5ZZMNd1C5SUBcs1v31JeKXF1z4Pcbj438AwzljUCP
	9U6Beb8Z+pJjO9OMyrj8P/PN+2qaYFmXSrxUrHjcuLx+a4A/jJpw8KhJwIikEPI16YSwLG
	2NKfDUzrHtZ9XHkgRBOda5R8QSleImT3M4AjCvKIi++BcHc86oFQjhjXOUA0gQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074357;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=TPEbHqe1uPycFyttd3bzZoDC9rFLGxIgSg4Vq1EaLF0=;
	b=DHqdZXP7JfsRMb86rtii48itNuSW7A7WdXXyGX8aiEFT6wBYEwUuod8u0DyKKL86Kxcpvv
	RCpYoEpj65PCS8DA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86/resctrl: Add energy/perf choices to rdt boot option
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807435671.510.2188274998747953660.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     842e7f97d71a4116a650ec0045d6444b4377b512
Gitweb:        https://git.kernel.org/tip/842e7f97d71a4116a650ec0045d6444b437=
7b512
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:21:11 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 09 Jan 2026 23:38:32 +01:00

x86/resctrl: Add energy/perf choices to rdt boot option

Legacy resctrl features are enumerated by X86_FEATURE_* flags. These may be
overridden by quirks to disable features in the case of errata.  Users can use
kernel command line options to either disable a feature, or to force enable
a feature that was disabled by a quirk.

A different approach is needed for hardware features that do not have an
X86_FEATURE_* flag.

Update parsing of the "rdt=3D" boot parameter to call the telemetry driver
directly to handle new "perf" and "energy" options that controls activation of
telemetry monitoring of the named type. By itself a "perf" or "energy" option
controls the forced enabling or disabling (with ! prefix) of all event groups
of the named type. A ":guid" suffix allows for fine grained control per event
group.

  [ bp: s/intel_aet_option/intel_handle_aet_option/g ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 Documentation/admin-guide/kernel-parameters.txt |  7 ++-
 arch/x86/kernel/cpu/resctrl/core.c              |  2 +-
 arch/x86/kernel/cpu/resctrl/intel_aet.c         | 38 ++++++++++++++++-
 arch/x86/kernel/cpu/resctrl/internal.h          |  2 +-
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/=
admin-guide/kernel-parameters.txt
index a8d0afd..abd77f3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6325,9 +6325,14 @@ Kernel parameters
 	rdt=3D		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec, abmc, sdciae.
+			mba, smba, bmec, abmc, sdciae, energy[:guid],
+			perf[:guid].
 			E.g. to turn on cmt and turn off mba use:
 				rdt=3Dcmt,!mba
+			To turn off all energy telemetry monitoring and ensure that
+			perf telemetry monitoring associated with guid 0x12345
+			is enabled use:
+				rdt=3D!energy,perf:0x12345
=20
 	reboot=3D		[KNL]
 			Format (x86 or x86_64):
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl=
/core.c
index 2514f15..e38d7fc 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -814,6 +814,8 @@ static int __init set_rdt_options(char *str)
 		force_off =3D *tok =3D=3D '!';
 		if (force_off)
 			tok++;
+		if (intel_handle_aet_option(force_off, tok))
+			continue;
 		for (o =3D rdt_options; o < &rdt_options[NUM_RDT_OPTIONS]; o++) {
 			if (strcmp(tok, o->name) =3D=3D 0) {
 				if (force_off)
diff --git a/arch/x86/kernel/cpu/resctrl/intel_aet.c b/arch/x86/kernel/cpu/re=
sctrl/intel_aet.c
index 9351fe5..dc25e8d 100644
--- a/arch/x86/kernel/cpu/resctrl/intel_aet.c
+++ b/arch/x86/kernel/cpu/resctrl/intel_aet.c
@@ -52,12 +52,17 @@ struct pmt_event {
 /**
  * struct event_group - Events with the same feature type ("energy" or "perf=
") and GUID.
  * @pfname:		PMT feature name ("energy" or "perf") of this event group.
+ *			Used by boot rdt=3D option.
  * @pfg:		Points to the aggregated telemetry space information
  *			returned by the intel_pmt_get_regions_by_feature()
  *			call to the INTEL_PMT_TELEMETRY driver that contains
  *			data for all telemetry regions of type @pfname.
  *			Valid if the system supports the event group,
  *			NULL otherwise.
+ * @force_off:		True when "rdt" command line or architecture code disables
+ *			this event group.
+ * @force_on:		True when "rdt" command line overrides disable of this
+ *			event group.
  * @guid:		Unique number per XML description file.
  * @mmio_size:		Number of bytes of MMIO registers for this group.
  * @num_events:		Number of events in this group.
@@ -67,6 +72,7 @@ struct event_group {
 	/* Data fields for additional structures to manage this group. */
 	const char			*pfname;
 	struct pmt_feature_group	*pfg;
+	bool				force_off, force_on;
=20
 	/* Remaining fields initialized from XML file. */
 	u32				guid;
@@ -121,6 +127,35 @@ static struct event_group *known_event_groups[] =3D {
 	     _peg < &known_event_groups[ARRAY_SIZE(known_event_groups)];	\
 	     _peg++)
=20
+bool intel_handle_aet_option(bool force_off, char *tok)
+{
+	struct event_group **peg;
+	bool ret =3D false;
+	u32 guid =3D 0;
+	char *name;
+
+	if (!tok)
+		return false;
+
+	name =3D strsep(&tok, ":");
+	if (tok && kstrtou32(tok, 16, &guid))
+		return false;
+
+	for_each_event_group(peg) {
+		if (strcmp(name, (*peg)->pfname))
+			continue;
+		if (guid && (*peg)->guid !=3D guid)
+			continue;
+		if (force_off)
+			(*peg)->force_off =3D true;
+		else
+			(*peg)->force_on =3D true;
+		ret =3D true;
+	}
+
+	return ret;
+}
+
 static bool skip_telem_region(struct telemetry_region *tr, struct event_grou=
p *e)
 {
 	if (tr->guid !=3D e->guid)
@@ -168,6 +203,9 @@ static bool enable_events(struct event_group *e, struct p=
mt_feature_group *p)
 	struct rdt_resource *r =3D &rdt_resources_all[RDT_RESOURCE_PERF_PKG].r_resc=
trl;
 	int skipped_events =3D 0;
=20
+	if (e->force_off)
+		return false;
+
 	if (!group_has_usable_regions(e, p))
 		return false;
=20
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/res=
ctrl/internal.h
index 3b228b2..61a2836 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -236,6 +236,7 @@ void __exit intel_aet_exit(void);
 int intel_aet_read_event(int domid, u32 rmid, void *arch_priv, u64 *val);
 void intel_aet_mon_domain_setup(int cpu, int id, struct rdt_resource *r,
 				struct list_head *add_pos);
+bool intel_handle_aet_option(bool force_off, char *tok);
 #else
 static inline bool intel_aet_get_events(void) { return false; }
 static inline void __exit intel_aet_exit(void) { }
@@ -246,6 +247,7 @@ static inline int intel_aet_read_event(int domid, u32 rmi=
d, void *arch_priv, u64
=20
 static inline void intel_aet_mon_domain_setup(int cpu, int id, struct rdt_re=
source *r,
 					      struct list_head *add_pos) { }
+static inline bool intel_handle_aet_option(bool force_off, char *tok) { retu=
rn false; }
 #endif
=20
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */

