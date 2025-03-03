Return-Path: <linux-tip-commits+bounces-3831-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1F5A4CBCB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 20:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 720123A7FAE
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC4723DE95;
	Mon,  3 Mar 2025 19:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iMR9sgok";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tb5UdCYo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA6D23BF88;
	Mon,  3 Mar 2025 19:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029189; cv=none; b=sNbwPqxHNln/lnuHtGEuUrI8kECsQ2ZZKxSZ4/H1KeGizW7NqwUrWUA8ihb6IGHD39b7lTeqp/ywcIL6qejaPnA+QIKWtV1Ne2hxU6g54HUOap8DewZEW91sCprAue3rE+9xyn2WNZFBFjAxDZV9bWa85KpAsy2ZKIxBO3tnSXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029189; c=relaxed/simple;
	bh=dSPSEqi9uf09k0gP41z/ZUegPXuuLN8hgBVuamJPiF0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pu8UeVust9VGCBinOtuUovCKdFedXUio2wS6d6F9mxcJGv8G8xYnVElqrlf+YePAWtIzoYMi+DnC+cxkqaDOcdGZKb0+wJrDFwXMTV/yqL0dG1fMltlqGUkHwf78Fn9mWCe88K/GYgE2I5fnZg4DiEnz+QxSFZ3MzXfIOxT9D6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iMR9sgok; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tb5UdCYo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 19:13:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741029186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/xbAD4ARIIVMNPfU1EXoaPetNkJa9JKbGTZwF+3Yxgg=;
	b=iMR9sgokCgddkMAUQa1dYc0i60lzr2Y1T/qf8QtWXo9pPUQbA62bALCI2E54NsahXPwo+C
	ZTjOXpe9FEIDjrGPZ6MDPFWlGO+wa5KDNYhZS4M3bIxZmdVK2zzVUVuQDsqyRkiw9HrSbg
	l2Y0GvO+MKDxjt44ey5yJJ5fv34cafdFMm5V4KmuAlUNBFXCOMIuIZZ8e8TvOuycnTxFpu
	LT45ChoVIi5CFze7RnEvbj4VAEsBHRVDXIqhRKv2ULoCppGixBur3NwJhZeFJDBZu8+jeR
	82VhbdCrp++GcSxYFprjcPKCi8T94S4oEJeIjxnLh1/BsBYQdNv9/m3ID7Ipaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741029186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/xbAD4ARIIVMNPfU1EXoaPetNkJa9JKbGTZwF+3Yxgg=;
	b=Tb5UdCYoH6+J6avbQOu0oRzJRdgqCo4O7BGj/e6q5kPBHYzHGABeo3Hoya8zaE+MbPQ8lE
	B734ZBh6y0VFO6Dw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] MAINTAINERS: Add vDSO selftests
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226-parse_vdso-nolibc-v2-1-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-1-28e14e031ed8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102918567.14745.13954372426545611119.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     ba2e35644d09af730880bb404bb6dd84685dcd7e
Gitweb:        https://git.kernel.org/tip/ba2e35644d09af730880bb404bb6dd84685=
dcd7e
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 26 Feb 2025 12:44:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 20:00:11 +01:00

MAINTAINERS: Add vDSO selftests

These currently have no maintainer besides the default kselftest ones.
Add the general vDSO maintainers, too.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/all/20250226-parse_vdso-nolibc-v2-1-28e14e031ed=
8@linutronix.de
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 25c86f4..74c6399 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9777,6 +9777,7 @@ F:	include/asm-generic/vdso/vsyscall.h
 F:	include/vdso/
 F:	kernel/time/vsyscall.c
 F:	lib/vdso/
+F:	tools/testing/selftests/vDSO/
=20
 GENWQE (IBM Generic Workqueue Card)
 M:	Frank Haverkamp <haver@linux.ibm.com>

