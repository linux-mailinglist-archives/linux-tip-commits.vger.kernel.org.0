Return-Path: <linux-tip-commits+bounces-6786-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8E6BD5F69
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Oct 2025 21:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E8340132B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Oct 2025 19:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AD7285C84;
	Mon, 13 Oct 2025 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ntz4xMNv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iCFrckBw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2682725783C;
	Mon, 13 Oct 2025 19:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760384219; cv=none; b=ZvromUSENObDcBlcRhG1h7Wo2VJaiPVHcPYec5Y3JALN9VlPyYOkso1S7+3yxLjR7FpMuwLujgCwjXjuEp5IQvLXnSlVIs5mOxkRsPaiK92dmXnHOfIHaKM1va2ktE1mO23ebquK4Zz0IctCwHm0jfjllx1tvCJySnVawQA/flQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760384219; c=relaxed/simple;
	bh=koMvvqOGoEq/+xhaY3yyrpBgHMwTEnvMywlodAFe2KQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=i9n2WYggqBnBx9btB8GUqn5egdJRqVrHpJTb1oTfwFisTqyPIKFCTUsPiB1tkaOpdvC97AYZfQ7xMD1moyIUDjXxIUbUBQ7t63Y+XrHNOHyyFFM04eYZ42/EC4RrlWtE9aZb5GbafjSRyw1FlnUWHk4NnkWnGrKBcxDZFP15bT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ntz4xMNv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iCFrckBw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 13 Oct 2025 19:36:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760384215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbqLX390oRV5icBXGh7n4ArAq7DSGrsaztVQlhVzIy0=;
	b=ntz4xMNvzYq4NYgwNNuNmQkSu86aUZzgmhyteXBTyaLenGMtYo/X8wZEt1PhucO+w88zVq
	+0zKv3mqFnYFB2AjTRikY6Bf+UgOFqa2SqX9PvvEQvvgA3ovcAHcs60oYamguvWHRskhjK
	if1CCpnNZvFc3S7c6jyJCPNpY80Bfr7E0rId+NY0eWPXJMxULIt1mQL/E+rSgreJ8LcYT6
	gC4UtbOoRSaO6h8fl7XnH8MP4iw/LYmVUoQAmd4FcDTH78PNJ5wskwS7ghQmIYDXyzaewf
	kIo7QaQkAtACwPhSK1NImFYOh6kKqT8f8fgrYKiw3AY2JQHD921Kltgb7waSlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760384215;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sbqLX390oRV5icBXGh7n4ArAq7DSGrsaztVQlhVzIy0=;
	b=iCFrckBwUf4McXlpyrcTMjHQntqn9hwKulSzx3kge0XcfltEboB+F7ii2r512FmWJEzpFO
	LXX9BoWEvOXdzpAA==
From: "tip-bot2 for Babu Moger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/resctrl: Fix miscount of bandwidth event when
 reactivating previously unavailable RMID
Cc: Babu Moger <babu.moger@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Reinette Chatre <reinette.chatre@intel.com>,
	"stable@vger.kernel.org # needs adjustments for" <=v6.17@tip-bot2.tec.linutronix.de>,
	x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <0475e18db309c3c912514a6c4e7f7626297faa2b.1760116015.git.babu.moger@amd.com>
References:
 <0475e18db309c3c912514a6c4e7f7626297faa2b.1760116015.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176038421418.709179.9899922862407222603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     15292f1b4c55a3a7c940dbcb6cb8793871ed3d92
Gitweb:        https://git.kernel.org/tip/15292f1b4c55a3a7c940dbcb6cb8793871e=
d3d92
Author:        Babu Moger <babu.moger@amd.com>
AuthorDate:    Fri, 10 Oct 2025 12:08:35 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 13 Oct 2025 21:24:39 +02:00

x86/resctrl: Fix miscount of bandwidth event when reactivating previously una=
vailable RMID

Users can create as many monitoring groups as the number of RMIDs supported
by the hardware. However, on AMD systems, only a limited number of RMIDs
are guaranteed to be actively tracked by the hardware. RMIDs that exceed
this limit are placed in an "Unavailable" state.

When a bandwidth counter is read for such an RMID, the hardware sets
MSR_IA32_QM_CTR.Unavailable (bit 62). When such an RMID starts being tracked
again the hardware counter is reset to zero. MSR_IA32_QM_CTR.Unavailable
remains set on first read after tracking re-starts and is clear on all
subsequent reads as long as the RMID is tracked.

resctrl miscounts the bandwidth events after an RMID transitions from the
"Unavailable" state back to being tracked. This happens because when the
hardware starts counting again after resetting the counter to zero, resctrl
in turn compares the new count against the counter value stored from the
previous time the RMID was tracked.

This results in resctrl computing an event value that is either undercounting
(when new counter is more than stored counter) or a mistaken overflow (when
new counter is less than stored counter).

Reset the stored value (arch_mbm_state::prev_msr) of MSR_IA32_QM_CTR to
zero whenever the RMID is in the "Unavailable" state to ensure accurate
counting after the RMID resets to zero when it starts to be tracked again.

Example scenario that results in mistaken overflow
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. The resctrl filesystem is mounted, and a task is assigned to a
   monitoring group.

   $mount -t resctrl resctrl /sys/fs/resctrl
   $mkdir /sys/fs/resctrl/mon_groups/test1/
   $echo 1234 > /sys/fs/resctrl/mon_groups/test1/tasks

   $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
   21323            <- Total bytes on domain 0
   "Unavailable"    <- Total bytes on domain 1

   Task is running on domain 0. Counter on domain 1 is "Unavailable".

2. The task runs on domain 0 for a while and then moves to domain 1. The
   counter starts incrementing on domain 1.

   $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
   7345357          <- Total bytes on domain 0
   4545             <- Total bytes on domain 1

3. At some point, the RMID in domain 0 transitions to the "Unavailable"
   state because the task is no longer executing in that domain.

   $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
   "Unavailable"    <- Total bytes on domain 0
   434341           <- Total bytes on domain 1

4.  Since the task continues to migrate between domains, it may eventually
    return to domain 0.

    $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
    17592178699059  <- Overflow on domain 0
    3232332         <- Total bytes on domain 1

In this case, the RMID on domain 0 transitions from "Unavailable" state to
active state. The hardware sets MSR_IA32_QM_CTR.Unavailable (bit 62) when
the counter is read and begins tracking the RMID counting from 0.

Subsequent reads succeed but return a value smaller than the previously
saved MSR value (7345357). Consequently, the resctrl's overflow logic is
triggered, it compares the previous value (7345357) with the new, smaller
value and incorrectly interprets this as a counter overflow, adding a large
delta.

In reality, this is a false positive: the counter did not overflow but was
simply reset when the RMID transitioned from "Unavailable" back to active
state.

Here is the text from APM [1] available from [2].

"In PQOS Version 2.0 or higher, the MBM hardware will set the U bit on the
first QM_CTR read when it begins tracking an RMID that it was not
previously tracking. The U bit will be zero for all subsequent reads from
that RMID while it is still tracked by the hardware. Therefore, a QM_CTR
read with the U bit set when that RMID is in use by a processor can be
considered 0 when calculating the difference with a subsequent read."

[1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
    Publication # 24593 Revision 3.41 section 19.3.3 Monitoring L3 Memory
    Bandwidth (MBM).

  [ bp: Split commit message into smaller paragraph chunks for better
    consumption. ]

Fixes: 4d05bf71f157d ("x86/resctrl: Introduce AMD QOS feature")
Signed-off-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Reinette Chatre <reinette.chatre@intel.com>
Cc: stable@vger.kernel.org # needs adjustments for <=3D v6.17
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537 # [2]
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resc=
trl/monitor.c
index c894561..2cd25a0 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -242,7 +242,9 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, struct=
 rdt_mon_domain *d,
 			   u32 unused, u32 rmid, enum resctrl_event_id eventid,
 			   u64 *val, void *ignored)
 {
+	struct rdt_hw_mon_domain *hw_dom =3D resctrl_to_arch_mon_dom(d);
 	int cpu =3D cpumask_any(&d->hdr.cpu_mask);
+	struct arch_mbm_state *am;
 	u64 msr_val;
 	u32 prmid;
 	int ret;
@@ -251,12 +253,16 @@ int resctrl_arch_rmid_read(struct rdt_resource *r, stru=
ct rdt_mon_domain *d,
=20
 	prmid =3D logical_rmid_to_physical_rmid(cpu, rmid);
 	ret =3D __rmid_read_phys(prmid, eventid, &msr_val);
-	if (ret)
-		return ret;
=20
-	*val =3D get_corrected_val(r, d, rmid, eventid, msr_val);
+	if (!ret) {
+		*val =3D get_corrected_val(r, d, rmid, eventid, msr_val);
+	} else if (ret =3D=3D -EINVAL) {
+		am =3D get_arch_mbm_state(hw_dom, rmid, eventid);
+		if (am)
+			am->prev_msr =3D 0;
+	}
=20
-	return 0;
+	return ret;
 }
=20
 static int __cntr_id_read(u32 cntr_id, u64 *val)

