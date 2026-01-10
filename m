Return-Path: <linux-tip-commits+bounces-7837-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A05D0DC1F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 20:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7BBA301EC76
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 Jan 2026 19:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFFA29B795;
	Sat, 10 Jan 2026 19:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UNDPHLl4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J6VQ5k7W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9873529A9C3;
	Sat, 10 Jan 2026 19:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768074315; cv=none; b=u8646mlq8KfgZD0WGz7TW3TYziyP9fFUSU5uDOnioumlC9UU0qzjchbJpWEegAURyg9ssZSb8Ja2rM8UkhymwJQjmoHGG1GQ5dtZd2NQ8YT+fCQ5D289ILpsjmATW7dANK4+eByGe/ecvbncL7WLMrc8P3dxDQN2eB+cp4XhKSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768074315; c=relaxed/simple;
	bh=yjtS9skL4bJjO82cHuoKjMLhuXl/+sax9rHVBElik7M=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=pAXJoBF9M6cAGlhy/FJE//ztK6lJjZbQtmRV7Mr8yJevF1Gp0S9p+A4ojn2lpp7jAuuoIsDNClChEPcfSZOxmvhGD1GZq12D2B1vjYXs/4nIT0IxXwiCg31iSrdP6XJUuxu4S7mwCyLVP1T0wKY65THkFvQgzvP3OuoXobLfZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UNDPHLl4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J6VQ5k7W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 10 Jan 2026 19:45:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768074305;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=QFoj+U2gdheW4kxwPe5vE/AK9DT3muauPO8i/3Yveek=;
	b=UNDPHLl4haAe+05jHV5DZXEKn0pfacUE669Kgq4YbjKa5ZApe8mT69hDfu9/pneZeFY926
	i8SV8AIDcB9k82UOd5ZTY5SuPeGXC688scXZ1IOc1mIGkBD+34vvfBqC+2rpBb1mxKQQRh
	ruyaiHX0JwRw2yICVqnJWG0CmaQh/2+KGTriDqqAEEr19pGOPWM32xHik5K1+1bsrCoJdj
	8RmR7RHobHZIT9MZ+vdwqCWDDCFmXRZLjHTt15N2UlMygTRx6J+yzOFnlYLI51r5K9vVHb
	MqyCZMY6SquzaW7dcyl3d5wopQP78+scAmFdDMbAgG8yRNK3tSokJ5rsCk+pPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768074305;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=QFoj+U2gdheW4kxwPe5vE/AK9DT3muauPO8i/3Yveek=;
	b=J6VQ5k7Wdi3Rche3Ks5Kuj+VeDkAuShN9/UMVo6bzs+oyYeehU8LEVHJotDbaU6P0IKnQf
	wemcfsGLaVVLedAw==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cache] x86,fs/resctrl: Update documentation for telemetry events
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176807430123.510.7100482884446961554.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     a8848c4b43ad00c8a18db080206e3ffa53a08b91
Gitweb:        https://git.kernel.org/tip/a8848c4b43ad00c8a18db080206e3ffa53a=
08b91
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Wed, 17 Dec 2025 09:21:19 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 10 Jan 2026 20:25:51 +01:00

x86,fs/resctrl: Update documentation for telemetry events

Update resctrl filesystem documentation with the details about the resctrl
files that support telemetry events.

  [ bp: Drop the debugfs hunk of the documentation until a better debugging
    solution is found. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/20251217172121.12030-1-tony.luck@intel.com
---
 Documentation/filesystems/resctrl.rst | 66 +++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 12 deletions(-)

diff --git a/Documentation/filesystems/resctrl.rst b/Documentation/filesystem=
s/resctrl.rst
index 8c8ce67..45dde87 100644
--- a/Documentation/filesystems/resctrl.rst
+++ b/Documentation/filesystems/resctrl.rst
@@ -252,13 +252,12 @@ with respect to allocation:
 			bandwidth percentages are directly applied to
 			the threads running on the core
=20
-If RDT monitoring is available there will be an "L3_MON" directory
+If L3 monitoring is available there will be an "L3_MON" directory
 with the following files:
=20
 "num_rmids":
-		The number of RMIDs available. This is the
-		upper bound for how many "CTRL_MON" + "MON"
-		groups can be created.
+		The number of RMIDs supported by hardware for
+		L3 monitoring events.
=20
 "mon_features":
 		Lists the monitoring events if
@@ -484,6 +483,24 @@ with the following files:
 		bytes) at which a previously used LLC_occupancy
 		counter can be considered for re-use.
=20
+If telemetry monitoring is available there will be a "PERF_PKG_MON" directory
+with the following files:
+
+"num_rmids":
+		The number of RMIDs for telemetry monitoring events.
+
+		On Intel resctrl will not enable telemetry events if the number of
+		RMIDs that can be tracked concurrently is lower than the total number
+		of RMIDs supported. Telemetry events can be force-enabled with the
+		"rdt=3D" kernel parameter, but this may reduce the number of
+		monitoring groups that can be created.
+
+"mon_features":
+		Lists the telemetry monitoring events that are enabled on this system.
+
+The upper bound for how many "CTRL_MON" + "MON" can be created
+is the smaller of the L3_MON and PERF_PKG_MON "num_rmids" values.
+
 Finally, in the top level of the "info" directory there is a file
 named "last_cmd_status". This is reset with every "command" issued
 via the file system (making new directories or writing to any of the
@@ -589,15 +606,40 @@ When control is enabled all CTRL_MON groups will also c=
ontain:
 When monitoring is enabled all MON groups will also contain:
=20
 "mon_data":
-	This contains a set of files organized by L3 domain and by
-	RDT event. E.g. on a system with two L3 domains there will
-	be subdirectories "mon_L3_00" and "mon_L3_01".	Each of these
-	directories have one file per event (e.g. "llc_occupancy",
-	"mbm_total_bytes", and "mbm_local_bytes"). In a MON group these
-	files provide a read out of the current value of the event for
-	all tasks in the group. In CTRL_MON groups these files provide
-	the sum for all tasks in the CTRL_MON group and all tasks in
+	This contains directories for each monitor domain.
+
+	If L3 monitoring is enabled, there will be a "mon_L3_XX" directory for
+	each instance of an L3 cache. Each directory contains files for the enabled
+	L3 events (e.g. "llc_occupancy", "mbm_total_bytes", and "mbm_local_bytes").
+
+	If telemetry monitoring is enabled, there will be a "mon_PERF_PKG_YY"
+	directory for each physical processor package. Each directory contains
+	files for the enabled telemetry events (e.g. "core_energy". "activity",
+	"uops_retired", etc.)
+
+	The info/`*`/mon_features files provide the full list of enabled
+	event/file names.
+
+	"core energy" reports a floating point number for the energy (in Joules)
+	consumed by cores (registers, arithmetic units, TLB and L1/L2 caches)
+	during execution of instructions summed across all logical CPUs on a
+	package for the current monitoring group.
+
+	"activity" also reports a floating point value (in Farads).  This provides
+	an estimate of work done independent of the frequency that the CPUs used
+	for execution.
+
+	Note that "core energy" and "activity" only measure energy/activity in the
+	"core" of the CPU (arithmetic units, TLB, L1 and L2 caches, etc.). They
+	do not include L3 cache, memory, I/O devices etc.
+
+	All other events report decimal integer values.
+
+	In a MON group these files provide a read out of the current value of
+	the event for all tasks in the group. In CTRL_MON groups these files
+	provide the sum for all tasks in the CTRL_MON group and all tasks in
 	MON groups. Please see example section for more details on usage.
+
 	On systems with Sub-NUMA Cluster (SNC) enabled there are extra
 	directories for each node (located within the "mon_L3_XX" directory
 	for the L3 cache they occupy). These are named "mon_sub_L3_YY"

