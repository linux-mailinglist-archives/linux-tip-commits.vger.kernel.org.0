Return-Path: <linux-tip-commits+bounces-3775-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA82DA4BCA3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD49216FDBB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597141F3FDD;
	Mon,  3 Mar 2025 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y/Bl58Md";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g4Z2i/6f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D4E1F3B83;
	Mon,  3 Mar 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998585; cv=none; b=S7Y3OexrUSiGnRbaXzEn4BA5SdsFcRxkKTbY6xobBwc4qRA+/GJHwGQYUtMu8KVmjHwWT434BnzNXLOfdbhU3UfEXs6rXZx/dDepTOMyl2964kHLzS7lumyIYzdTkk6PksYKSP0k+azYkVADiCC2Wx4iln3/pC3Px1REDq5YA30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998585; c=relaxed/simple;
	bh=lx74Pwl1kqb4Is9t/l+V5crR2b9maM+CLRFg4/+YTR0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=cpdXH3YucthnhhGKF+YzxCk+H4ACnZxllrooU8eXrpGFHA+7Q12EC6GPYeZ/+HqxjkuCDPV8yxe8L1jlGGScn9jMmrAETneNjyGQpl95+o560/iiwF0MqdEVS1p3fZpnLDDNxtGYZhbw0fc2nize+anVH4w08NSstaurpAKH1Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y/Bl58Md; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g4Z2i/6f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:43:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740998581;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=26v5pEy0suuIUPWxFzVBdqyL8BpRD3AbrEJxB5wD+AQ=;
	b=Y/Bl58MdK7vO4J/SgfcCHA9so1QILznlsUqJDNoP9tms/z7tJPlGSxmBWCUCftsFMDoMKU
	/SevqPVPBPGcHG5e2lniKo6zh1tcRdFvxG0eEDc69NdmHU5UWIZ9O6RdzjFs1IBevTQXJJ
	aR/uqjL94X/57FThw4ek9IHWTPeOLB1QSW0+y3JPGOe6Me0LEBGm1KroT0ppuinuLLMNzA
	5+wNommk9gQfSdqlU4Zs8oHXb4ePAy9feqgvZOsDYC2ImZ6W8HCfkhdwi1o+YU6rbPbfjv
	0q0pacwHxFexnY+rmHwR5uHx82UHv4c8yr3hNiFBI3tGBgtg3LNao9hwL9kvnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740998581;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=26v5pEy0suuIUPWxFzVBdqyL8BpRD3AbrEJxB5wD+AQ=;
	b=g4Z2i/6fZq9KCAEM857MFOXRnMUsyI+159MoItLZYTLkQVTd01goPMk+bPhLuL/vCzuw+K
	9tBBg1wosTsOk6BQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso/namespace: Rename timens_setup_vdso_data() to
 reflect new vdso_clock struct
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174099858137.10177.11699219638231482841.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     1b1ef5d92289204cf1c96deb5967156e4329062b
Gitweb:        https://git.kernel.org/tip/1b1ef5d92289204cf1c96deb5967156e432=
9062b
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 25 Feb 2025 13:36:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 10:24:35 +01:00

vdso/namespace: Rename timens_setup_vdso_data() to reflect new vdso_clock str=
uct

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it.

For time namespace, vdso_time_data needs to be set up. But this is only the
clock related part of the vdso_data thats requires this setup. To reflect
the future struct vdso_clock, rename timens_setup_vdso_data() to
timns_setup_vdso_clock_data().

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 kernel/time/namespace.c | 6 +++---
 lib/vdso/datastore.c    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 12f55aa..f02430a 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -176,8 +176,8 @@ static struct timens_offset offset_from_ts(struct timespe=
c64 off)
  * Timens page has vdso_time_data->clock_mode set to VDSO_CLOCKMODE_TIMENS w=
hich
  * enforces the time namespace handling path.
  */
-static void timens_setup_vdso_data(struct vdso_time_data *vdata,
-				   struct time_namespace *ns)
+static void timens_setup_vdso_clock_data(struct vdso_time_data *vdata,
+					 struct time_namespace *ns)
 {
 	struct timens_offset *offset =3D vdata->offset;
 	struct timens_offset monotonic =3D offset_from_ts(ns->offsets.monotonic);
@@ -238,7 +238,7 @@ static void timens_set_vvar_page(struct task_struct *task,
 	vdata =3D page_address(ns->vvar_page);
=20
 	for (i =3D 0; i < CS_BASES; i++)
-		timens_setup_vdso_data(&vdata[i], ns);
+		timens_setup_vdso_clock_data(&vdata[i], ns);
=20
 out:
 	mutex_unlock(&offset_lock);
diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index e227fbb..4e350f5 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -109,7 +109,7 @@ struct vm_area_struct *vdso_install_vvar_mapping(struct m=
m_struct *mm, unsigned=20
  * non-root time namespace. Whenever a task changes its namespace, the VVAR
  * page tables are cleared and then they will be re-faulted with a
  * corresponding layout.
- * See also the comment near timens_setup_vdso_data() for details.
+ * See also the comment near timens_setup_vdso_clock_data() for details.
  */
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {

