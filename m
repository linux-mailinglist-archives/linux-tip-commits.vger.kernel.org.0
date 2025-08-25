Return-Path: <linux-tip-commits+bounces-6346-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C01B33C93
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 12:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEE407A126A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 25 Aug 2025 10:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964362E1C7C;
	Mon, 25 Aug 2025 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a03tKU2y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4OReTU7e"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013882D8795;
	Mon, 25 Aug 2025 10:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117478; cv=none; b=XieZkdpSsXbFAi9EUjONBAoqM/20QsSErKHriEsUyQ5znlrBfPPnGiilVXHbI8RlUj+td329gQIaGdvuIKgsMHacFQNhGL57OwFF/75+Cxq35qemAe8TTG5Qdp1XuFNrn9nwo/W377wzgLCvG5w3rmG6Zj3ATm315GWo09PNgaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117478; c=relaxed/simple;
	bh=rkVne/1fwNvyWL+u9OA2lZK6hsKuPXlv/x3zOpToQ4M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FOxjykjIbl6efieQYlVMJi8IjYStbTXKhzHDEmlZ2Eo6Vz7wsIaxAE3lLeJRhWz54XQCPYir/JHBJGIqx4mbhre7yIzJvfuhCeGNQcToi/zNBjC78gq/eoGp0/Qn4kcjpuLRSTXpNgHoSxohwRjQGzrBTkWMTmKaP+cD7uaNKqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a03tKU2y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4OReTU7e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Aug 2025 10:24:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756117474;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2WgoAa7CJyw90bgmwgKKqABexcrWru3lZ5wm8spH3+E=;
	b=a03tKU2yWzyW40hWd7ypTm4owjBjGxibcj4d/XFVZfCsS3bZNDjrRDA0MtEvUkc8FDDBsr
	bTU33pzaVNipJorMpyK0v7u26gt0eu5nhPtNXnJPGP1qy+RmePngnM+lUPtn4QoRLLcyME
	uCVS7YfYx5nOO9qRvg985DBkGA8tGnYLHrqS38NJvoCi3UTvdyq38+g29M1BR3hea9OHYh
	2bp7w6rGKjm7Arblh/s5V4Hfw/3fVe6O/mISUciwTBYn31UL7QxsR2YVlegXfWwPQ6G682
	Sdw5gFHVsIzg5NVdBVlu4FQmNq4xankKp24MLTCuUj46WOIURs/vCtwc/C3xpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756117474;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2WgoAa7CJyw90bgmwgKKqABexcrWru3lZ5wm8spH3+E=;
	b=4OReTU7eKxwlplm6owULuuvRmNsIvlZox/nMSy0MR2H3mM2aFXMaJSLRqMOtKbIX3PNxVJ
	/vEvnBJ1VLBHEbAQ==
From: "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] seccomp: passthrough uprobe systemcall without filtering
Cc: Jiri Olsa <jolsa@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Kees Cook <kees@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250720112133.244369-21-jolsa@kernel.org>
References: <20250720112133.244369-21-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175611747329.1420.15577078334005651636.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     89d1d8434d246c96309a6068dfcf9e36dc61227b
Gitweb:        https://git.kernel.org/tip/89d1d8434d246c96309a6068dfcf9e36dc6=
1227b
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Sun, 20 Jul 2025 13:21:30 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 21 Aug 2025 20:09:26 +02:00

seccomp: passthrough uprobe systemcall without filtering

Adding uprobe as another exception to the seccomp filter alongside
with the uretprobe syscall.

Same as the uretprobe the uprobe syscall is installed by kernel as
replacement for the breakpoint exception and is limited to x86_64
arch and isn't expected to ever be supported in i386.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kees Cook <kees@kernel.org>
Link: https://lore.kernel.org/r/20250720112133.244369-21-jolsa@kernel.org
---
 kernel/seccomp.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 41aa761..7daf2da 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -741,6 +741,26 @@ out:
 }
=20
 #ifdef SECCOMP_ARCH_NATIVE
+static bool seccomp_uprobe_exception(struct seccomp_data *sd)
+{
+#if defined __NR_uretprobe || defined __NR_uprobe
+#ifdef SECCOMP_ARCH_COMPAT
+	if (sd->arch =3D=3D SECCOMP_ARCH_NATIVE)
+#endif
+	{
+#ifdef __NR_uretprobe
+		if (sd->nr =3D=3D __NR_uretprobe)
+			return true;
+#endif
+#ifdef __NR_uprobe
+		if (sd->nr =3D=3D __NR_uprobe)
+			return true;
+#endif
+	}
+#endif
+	return false;
+}
+
 /**
  * seccomp_is_const_allow - check if filter is constant allow with given data
  * @fprog: The BPF programs
@@ -758,13 +778,8 @@ static bool seccomp_is_const_allow(struct sock_fprog_ker=
n *fprog,
 		return false;
=20
 	/* Our single exception to filtering. */
-#ifdef __NR_uretprobe
-#ifdef SECCOMP_ARCH_COMPAT
-	if (sd->arch =3D=3D SECCOMP_ARCH_NATIVE)
-#endif
-		if (sd->nr =3D=3D __NR_uretprobe)
-			return true;
-#endif
+	if (seccomp_uprobe_exception(sd))
+		return true;
=20
 	for (pc =3D 0; pc < fprog->len; pc++) {
 		struct sock_filter *insn =3D &fprog->filter[pc];
@@ -1043,6 +1058,9 @@ static const int mode1_syscalls[] =3D {
 #ifdef __NR_uretprobe
 	__NR_uretprobe,
 #endif
+#ifdef __NR_uprobe
+	__NR_uprobe,
+#endif
 	-1, /* negative terminated */
 };
=20

