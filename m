Return-Path: <linux-tip-commits+bounces-7155-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ECCC2875E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622871884309
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D75830FC2A;
	Sat,  1 Nov 2025 19:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PWatO6bh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MXpEs2nx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F338E30F53B;
	Sat,  1 Nov 2025 19:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026487; cv=none; b=jjzJUubt9wrWGyvrRSFKG7Dexl3JOz+IWBEA/j0zeOZSJzNhXcd+uLcFen69f2+s7cQ4bgsWPrW2khTo2rK44soVIsG+Qi2kF40m3d5xhAAp9aaMNqUXN+J1h+7irzrWIjZSx85Wvr1HaxW96NKaB18iodHAnlkF9OJ5wIF47H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026487; c=relaxed/simple;
	bh=qO3r7ehgur/urgMp6baIxbC8Zq+yBRo4P8djHyepfak=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BA5xzJ2J2Xg75WkDf5zAwc3ao5p90kqBGghDLDCRztteGmmrEfXmHdWlgr5xUCSMsZp6wjNh4/7Zk1D++WoAlkdvKaofMSC4VG2qPaoCeBzHHVAE63zhQ0kHy9HG23blV3hMj3elxXc02vShIFtUf5h47j/QE86sXzcZTuVYjiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PWatO6bh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MXpEs2nx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:48:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026484;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyNIzSvs8TxRXQp1vmr5tnvztsdDopZ5KGLj9eG/Q2U=;
	b=PWatO6bhAEDft0axxQEx75jIjv5bU3/6jnroo1kYe9HKljBMrk+13FoW08hQKzHhS4S4MW
	6hXZYCUrDihVRnTLtudm3lNJIz332S9RahAv/P6hfje0J6gS7geO47DeJU21/Sutj1M3rG
	97fhqve4nyXMzaKBQpW2NntAGxzLBJsrJz4UVnzRy0uKKfA4cORtS56XmyvJDONLoCSa8B
	TO7TjN9qOLWiUWOiti6ImfuwwtsIN+75o2Ui/XWy0BGkFT4E4xS5quydzpVPQysR9WonLr
	7ZkSAJsCxfASRs+9LqUt6MJ7qw629/Y9vKTy9jr8+2bplg+S4zWl9YeeO/kzWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026484;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nyNIzSvs8TxRXQp1vmr5tnvztsdDopZ5KGLj9eG/Q2U=;
	b=MXpEs2nxRY4kJ1WRWdXJVmCT2R1OdZFpeK/P66nS4W0fGDnUuQ3ss1LziFlF6yzT7TmLse
	2xVG4zKOh2odjfCw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] random: vDSO: Add explicit includes
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-11-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-11-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202648302.2601451.11792032920339068305.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     a0d9149cced957aaf532a64ca3bd69937032e7fc
Gitweb:        https://git.kernel.org/tip/a0d9149cced957aaf532a64ca3bd6993703=
2e7fc
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:48:57 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:04 +01:00

random: vDSO: Add explicit includes

Various used symbols are only visible through transitive includes.
These transitive includes are about to go away.

Explicitly include the necessary headers.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-11-e0607bf4=
9dea@linutronix.de
---
 lib/vdso/getrandom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/vdso/getrandom.c b/lib/vdso/getrandom.c
index 440f8a6..7e29005 100644
--- a/lib/vdso/getrandom.c
+++ b/lib/vdso/getrandom.c
@@ -7,8 +7,11 @@
 #include <linux/minmax.h>
 #include <vdso/datapage.h>
 #include <vdso/getrandom.h>
+#include <vdso/limits.h>
 #include <vdso/unaligned.h>
+#include <asm/barrier.h>
 #include <asm/vdso/getrandom.h>
+#include <uapi/linux/errno.h>
 #include <uapi/linux/mman.h>
 #include <uapi/linux/random.h>
=20

