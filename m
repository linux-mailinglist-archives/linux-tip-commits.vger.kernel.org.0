Return-Path: <linux-tip-commits+bounces-4079-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 642F4A57AA3
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 14:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA12518906CF
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 13:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE301DE4E7;
	Sat,  8 Mar 2025 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uXBHFj3E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/5RRNX3x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54D11D958E;
	Sat,  8 Mar 2025 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441504; cv=none; b=ZYq+KUvhmCqX/xcLkmAKcO5UMMHBEiVy4yrBjFYT+xmJ4toqXDo2ib3w7B1rPhEAKJtDshFYwM7o/Qfgj1L+5a2L4GoxfIUHJLYGF+oIjbYpu98w2CM8higYMjFTsaM4PSCr+k4pmsrVs8XEfbF0LJEewk9LdgMWJqUF1FhcKdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441504; c=relaxed/simple;
	bh=L+U278oJKCTKYHNcrT44B3QKQhRAx22kM1/db6Gjc2I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OiOeSGsCmiGIPDGCG8keJjmafZbhXeuA6u7DTkEV/0szbRY0s6IWm2vXQ00/1/biyCsytE1l0GOPMMxcni+vA5DhpsN2iArRwO0ysfORqNIPTtYMxkSRUSCdFdAuMaizm6+mIyCp2sak02rIn250BERLRDqGPeIwk4x2JGD5rUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uXBHFj3E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/5RRNX3x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 13:44:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741441500;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tYnL+EfQaGeuYy8HFF8QqKDi0JQhHnnmCJ6G2GtGgao=;
	b=uXBHFj3EeYcKbC5wsqidtUdK+wfse2aJc8t80lqXPHQcAbIn4B7PAd8/9ZCILcn8VUNlU8
	D4T8CbW1+IUP+qaMCqUmfCCGsOw4Z52sh3A5grgUdp3Smk7qJvEJjVVH+f4UiRuh7qB4b2
	mAvK8GbmT1oX1bfK83dT7lxL39V9oys2K08rBMPSk8gAeuqI3daPlRtyCXkrPTS5pevhuN
	aCjamWHXEt18JfGO8bXi/cYdQD4sqlsRCM2mIu0inU3YzKAwxZpUnYaLe1AjWBHeLe6nbO
	i7dvf3DPoatQVVmN/P1cs+qjgIqQ+0PHw7nUpxS9KJklEhXhYr2KnnlXTu12Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741441500;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tYnL+EfQaGeuYy8HFF8QqKDi0JQhHnnmCJ6G2GtGgao=;
	b=/5RRNX3xd4izNdwdV6ujYScLvxXZcc10ISuiW1YDHZI0CBvvI5MdAhlkR1y9BSa56/JlMP
	PnZhqeuJFxvkj9CQ==
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
In-Reply-To: <20250303-vdso-clock-v1-13-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-13-c1b5c69a166f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174144149969.14745.16609971831838306757.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     0235220807033c7a1dc2a96cc23b6eae0dd11c81
Gitweb:        https://git.kernel.org/tip/0235220807033c7a1dc2a96cc23b6eae0dd=
11c81
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 03 Mar 2025 12:11:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 08 Mar 2025 14:37:41 +01:00

vdso/namespace: Rename timens_setup_vdso_data() to reflect new vdso_clock str=
uct

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of VDSO clocks. At the moment,
vdso_clock is simply a define which maps vdso_clock to vdso_time_data.

For time namespaces, vdso_time_data needs to be set up. But only the clock
related part of the vdso_data thats requires this setup. To reflect the
future struct vdso_clock, rename timens_setup_vdso_data() to
timns_setup_vdso_clock_data().

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250303-vdso-clock-v1-13-c1b5c69a166f@linu=
tronix.de

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

