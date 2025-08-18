Return-Path: <linux-tip-commits+bounces-6275-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A55ABB29F19
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 12:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB23E2A61E6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 18 Aug 2025 10:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A112C2358;
	Mon, 18 Aug 2025 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hRALGA47";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jO+rx8Ot"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DB82765FB;
	Mon, 18 Aug 2025 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755512557; cv=none; b=MUvvNPy97K8xMrdF5knpIMyVYP0NM/tKdP+3fkCQ//k0AUF8cuTTQFLkr+DiGNcTuRx1nzVuaDhdzP0zUhfUJ6haCwSemQzKVWdtnA/rjcJZmi4cnvdn4zqF2ZfbNjL6JTm64D7it9FGwQzaxGjUThje89stnDbs+uHV5ik/G0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755512557; c=relaxed/simple;
	bh=9rQfe9oowcm9KV1qYtyEf9iCf0IEpjTH3mveQktEvs0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RWWUefsgF1xYotkZoeZWiOmYtt4Wvq2AVSL1rE4sNAi7cppMqWWSxsbDcBrUEbzl1QXkopj1IpW1/BuP7pA4+fY+koNOQsSEj502SSjd/YTBCVDU/CWZIxm7P38Hl029Da7v1F2I0Q1NBf+/CrF8luMrc6APXt6pzg82yq0g5Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hRALGA47; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jO+rx8Ot; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 18 Aug 2025 10:22:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755512555;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9rh2DKgtGVg8KZ15FbUVvXFY8jG0x4wWEAwWGAHrE74=;
	b=hRALGA47l2jx6JGOebvuJGF2uitRhLGRTL4+cID2l68AV9dGpTUDzUil4X1jmq3jr6TYX5
	tneWvgvZrpPR+tAByhKMzu6N2CrIQPGLjiKNZsFxz88nDzlCMy+Poi2q43ju/hPnFpVUzl
	pZ6i+ke7F4rSIYBLDviCAwrLQjZwDH+2JsU8LBflrNGS9QE0TCTmDJW1T4IBu/wY+Gulpf
	AyGV2uat5IsQThnC4p9eBOvAsNZnUkhI7xTkyTOy7Tbh1HOltOS/6YSPscS8zhnDferesJ
	9e7XrGoGuFCkDXzArOVc8TTv7nBgA6bmmXmTSKMkWj2yxMfODujywBbQUHDM5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755512555;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9rh2DKgtGVg8KZ15FbUVvXFY8jG0x4wWEAwWGAHrE74=;
	b=jO+rx8OtzX6XPMF+ZdBm2C+mXX6odHKiqV5nohDaF2L7JeHri694Jkn7GDMdJ2T+b/42EO
	4sSHnMv7PW1GlSAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Split out VM accounting
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250812104018.660347811@infradead.org>
References: <20250812104018.660347811@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175551255390.1420.14980120167011972513.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1ea3e3b0dadc06c5e6c1bdf5312e70ee861b1ba0
Gitweb:        https://git.kernel.org/tip/1ea3e3b0dadc06c5e6c1bdf5312e70ee861=
b1ba0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 12 Aug 2025 12:39:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Aug 2025 13:12:59 +02:00

perf: Split out VM accounting

Similarly to the mlock limit calculation the VM accounting is required for
both the ringbuffer and the AUX buffer allocations.

To prepare for splitting them out into separate functions, move the
accounting into a helper function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Link: https://lore.kernel.org/r/20250812104018.660347811@infradead.org
---
 kernel/events/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f629901..f908471 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6962,10 +6962,17 @@ static bool perf_mmap_calc_limits(struct vm_area_stru=
ct *vma, long *user_extra,=20
 	return locked <=3D lock_limit || !perf_is_paranoid() || capable(CAP_IPC_LOC=
K);
 }
=20
+static void perf_mmap_account(struct vm_area_struct *vma, long user_extra, l=
ong extra)
+{
+	struct user_struct *user =3D current_user();
+
+	atomic_long_add(user_extra, &user->locked_vm);
+	atomic64_add(extra, &vma->vm_mm->pinned_vm);
+}
+
 static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct perf_event *event =3D file->private_data;
-	struct user_struct *user =3D current_user();
 	unsigned long vma_size, nr_pages;
 	long user_extra =3D 0, extra =3D 0;
 	struct mutex *aux_mutex =3D NULL;
@@ -7136,9 +7143,7 @@ static int perf_mmap(struct file *file, struct vm_area_=
struct *vma)
=20
 unlock:
 	if (!ret) {
-		atomic_long_add(user_extra, &user->locked_vm);
-		atomic64_add(extra, &vma->vm_mm->pinned_vm);
-
+		perf_mmap_account(vma, user_extra, extra);
 		atomic_inc(&event->mmap_count);
 	} else if (rb) {
 		/* AUX allocation failed */

