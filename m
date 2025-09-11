Return-Path: <linux-tip-commits+bounces-6564-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74098B52E59
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 12:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E9E3A58EA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 10:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3BD313E23;
	Thu, 11 Sep 2025 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XLdcD+sp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bKPKvChg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10567313532;
	Thu, 11 Sep 2025 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586543; cv=none; b=YjSBY4PEPQ25xhXd2SVPzMXd2CVeot+y7mnSvVZBXIEk3XVBrMjS1wX/weHWYlGJE3mV77iLuuWo5xXNbVb2YmBRzqICdTNO3q4hlULJ8xlX+tmsukXU7q62I2/mDDhtR/YFiSPxW1kd8cmISvk3TzSQuiDDYIdivdLJ3RDXVrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586543; c=relaxed/simple;
	bh=JoQE42PndkYh2ZpH5Z/I4EBYdqTQ/rC/Pi07KeUpUAw=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=DY1M+Yy3jNyKR5NfNAPocTbjZQBp1gE1PeiDYj30yLAV+5QQux/bw8qyks68ZCXW7tDbDeqrdUUIvuObKUdGBsrv3n+BNhnSwtB6Coq/MXeIQHOU025io4R+ehX+c0vI2yX2zIVvN2IU06CmQPdK9d9AvqeGnYlI8I2v/5s4SWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XLdcD+sp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bKPKvChg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 10:28:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757586540;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=g5WhIfJRvCyVG8NUvrewQT8NwvgG7N7trn54du6Ooxg=;
	b=XLdcD+sp8ARyZpxB1NTjKTjtKY6kXovhwIvZ1Ssrta7qSpvOdYFcrVJA7GkLRSvmPwm1Ja
	hEjqnace3Y9kOa7zTuwfqYNgwnXW2nkvAPnK6e0bY6Z2iq33qk3wBLHWBgg1aSiZ9Q0BPo
	2ur/kPX1Nu11zwracGrAt4hz7zP6fkXtgwPQ49lYF2fQcjRr8qwK1RJddTe1AQ1NuLNitd
	xa9YYef//efQYXn32Jtij7dAke0978ut8bNsAGcwAqo6odBOU77afSXtHh5H8yHno5A3Xr
	CP0HW75z4o9cvBRN7gplnZ8hztacXw5/l+6OvCKccfqCYJu8BoB33PxhlwgE9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757586540;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=g5WhIfJRvCyVG8NUvrewQT8NwvgG7N7trn54du6Ooxg=;
	b=bKPKvChgtZeJJCl2+i0hZPPibiVaJKQRIGbHcMd50bXu6+FKNutll1lRM/1LT8o7gVn+bS
	WFmaTlsp3fws5fCA==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Move machine_check_poll() status checks to
 helper functions
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Tony Luck <tony.luck@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175758653917.709179.7141514378637292570.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     91af6842e9945d064401ed2d6e91539a619760d1
Gitweb:        https://git.kernel.org/tip/91af6842e9945d064401ed2d6e91539a619=
760d1
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 08 Sep 2025 15:40:35=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 11 Sep 2025 12:23:22 +02:00

x86/mce: Move machine_check_poll() status checks to helper functions

There are a number of generic and vendor-specific status checks in
machine_check_poll(). These are used to determine if an error should be
skipped.

Move these into helper functions. Future vendor-specific checks will be
added to the helpers.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.=
com
---
 arch/x86/kernel/cpu/mce/core.c | 88 ++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 40 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7fd86c8..5dec0da 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -715,6 +715,52 @@ static noinstr void mce_read_aux(struct mce_hw_err *err,=
 int i)
 DEFINE_PER_CPU(unsigned, mce_poll_count);
=20
 /*
+ * Newer Intel systems that support software error
+ * recovery need to make additional checks. Other
+ * CPUs should skip over uncorrected errors, but log
+ * everything else.
+ */
+static bool ser_should_log_poll_error(struct mce *m)
+{
+	/* Log "not enabled" (speculative) errors */
+	if (!(m->status & MCI_STATUS_EN))
+		return true;
+
+	/*
+	 * Log UCNA (SDM: 15.6.3 "UCR Error Classification")
+	 * UC =3D=3D 1 && PCC =3D=3D 0 && S =3D=3D 0
+	 */
+	if (!(m->status & MCI_STATUS_PCC) && !(m->status & MCI_STATUS_S))
+		return true;
+
+	return false;
+}
+
+static bool should_log_poll_error(enum mcp_flags flags, struct mce_hw_err *e=
rr)
+{
+	struct mce *m =3D &err->m;
+
+	/* If this entry is not valid, ignore it. */
+	if (!(m->status & MCI_STATUS_VAL))
+		return false;
+
+	/*
+	 * If we are logging everything (at CPU online) or this
+	 * is a corrected error, then we must log it.
+	 */
+	if ((flags & MCP_UC) || !(m->status & MCI_STATUS_UC))
+		return true;
+
+	if (mca_cfg.ser)
+		return ser_should_log_poll_error(m);
+
+	if (m->status & MCI_STATUS_UC)
+		return false;
+
+	return true;
+}
+
+/*
  * Poll for corrected events or events that happened before reset.
  * Those are just logged through /dev/mcelog.
  *
@@ -765,48 +811,10 @@ void machine_check_poll(enum mcp_flags flags, mce_banks=
_t *b)
 		if (!mca_cfg.cmci_disabled)
 			mce_track_storm(m);
=20
-		/* If this entry is not valid, ignore it */
-		if (!(m->status & MCI_STATUS_VAL))
+		/* Verify that the error should be logged based on hardware conditions. */
+		if (!should_log_poll_error(flags, &err))
 			continue;
=20
-		/*
-		 * If we are logging everything (at CPU online) or this
-		 * is a corrected error, then we must log it.
-		 */
-		if ((flags & MCP_UC) || !(m->status & MCI_STATUS_UC))
-			goto log_it;
-
-		/*
-		 * Newer Intel systems that support software error
-		 * recovery need to make additional checks. Other
-		 * CPUs should skip over uncorrected errors, but log
-		 * everything else.
-		 */
-		if (!mca_cfg.ser) {
-			if (m->status & MCI_STATUS_UC)
-				continue;
-			goto log_it;
-		}
-
-		/* Log "not enabled" (speculative) errors */
-		if (!(m->status & MCI_STATUS_EN))
-			goto log_it;
-
-		/*
-		 * Log UCNA (SDM: 15.6.3 "UCR Error Classification")
-		 * UC =3D=3D 1 && PCC =3D=3D 0 && S =3D=3D 0
-		 */
-		if (!(m->status & MCI_STATUS_PCC) && !(m->status & MCI_STATUS_S))
-			goto log_it;
-
-		/*
-		 * Skip anything else. Presumption is that our read of this
-		 * bank is racing with a machine check. Leave the log alone
-		 * for do_machine_check() to deal with it.
-		 */
-		continue;
-
-log_it:
 		mce_read_aux(&err, i);
 		m->severity =3D mce_severity(m, NULL, NULL, false);
 		/*

