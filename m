Return-Path: <linux-tip-commits+bounces-3784-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5841A4BCBA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:45:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCBE3ACBDA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E441F540F;
	Mon,  3 Mar 2025 10:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aOlE/8+3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S56RAuva"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23991F4619;
	Mon,  3 Mar 2025 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998589; cv=none; b=EE19w+M6SZot8DyLtl5JCq1e+LId//So1k7ByR/zAqMcSHw7CxHgUKn0Ju0zrBxA+/m0vf2GdTVfsRym/nyuaWBBhCAOjniUtwZzMkckywl4sPfv/YLAYQA9PRTmRkdBH7iSd580Ee15SF4pmP0XdKYzc/hXFL+/1QvZ0arw69M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998589; c=relaxed/simple;
	bh=efo4wBFzrjlQS7x/6bY6ma6DFCVjMxys/5b58eXcp80=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=hos1LfP/JWv0edTbd4jLYC95Hh4fo9I74uXr96fv12fsSWYQNtTzHh7ah22gf32uQCTqEG8LNQxE5EW16nYNVruhmfViRR/o2OrjQUYEmDT16W7Vc+/0k20ILII5zfPvmjMFpUY8vnH1Mk+SFmnG33RcWStlxT9OiCvxwsye3IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aOlE/8+3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S56RAuva; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:43:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740998586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=uPZKwedrrxSDqoiKRYWnXEj1mHKoY7XFb9YTjgF/cAY=;
	b=aOlE/8+3MmJ078kzonvabWvHwWAr44FNDV1saSwmYYZDv9K0DkeGN3D20n7i3hMuZMJBnE
	xn1tip3wjSGaypxB1wIA8Y0KP1tnLAxPSYCQ4cMwvkI5ihx/u+iHjROt050Vd2GhHQOXCL
	cz2BKbv4ZGtZzPZekO6cB4e074tTxivjPLQN4KCgPTVmGD1lo1Xbl68B2O6racMVmIAlIM
	XtPN2lot2AMkzid87idM0R+Zz1r2MkpVFieR4VsOv2sKdmMJLRpIBQucAzekLiP22fackp
	flRkJWhh5AfxZmmVmyyJAmzSsUQ/pSeTKnAJmkObHcs7vBPuqBmCqq5V8M8ntQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740998586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=uPZKwedrrxSDqoiKRYWnXEj1mHKoY7XFb9YTjgF/cAY=;
	b=S56RAuva0H5aHV988q5a6pcp/QFRhn63iJIr8SOpQ0u/EV/7I/YKiqhNxVIUJkAdnf1aYx
	g/Fg5a8HciRA5nBQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso/datapage: Define for vdso_data to make rework
 of vdso possible
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
Message-ID: <174099858572.10177.12620599034642529930.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     0065d63c517b3c18a18b30049c7e93661fac8270
Gitweb:        https://git.kernel.org/tip/0065d63c517b3c18a18b30049c7e93661fa=
c8270
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 25 Feb 2025 13:36:36 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 10:24:34 +01:00

vdso/datapage: Define for vdso_data to make rework of vdso possible

PTP clocks could also be supported by the vdso to use the advantages of
this implementation. Therefore the struct must be reworked. For a
transition to the new structure of the vdso, add a define which maps
vdso_clock to vdso_data. This will be removed when all users are updated
step by step.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 include/vdso/datapage.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index dfd98f9..1df22e8 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -129,6 +129,8 @@ struct vdso_time_data {
 	struct arch_vdso_time_data arch_data;
 } ____cacheline_aligned;
=20
+#define vdso_clock vdso_time_data
+
 /**
  * struct vdso_rng_data - vdso RNG state information
  * @generation:	counter representing the number of RNG reseeds

