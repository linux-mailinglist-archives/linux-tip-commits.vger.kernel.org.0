Return-Path: <linux-tip-commits+bounces-7948-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E260D192C6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 14:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D9E730A7C1C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 13:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC23D3921D0;
	Tue, 13 Jan 2026 13:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ceLlcXYF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pgKP6SnB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D961738F944;
	Tue, 13 Jan 2026 13:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312059; cv=none; b=ButGiDmG4pxJxZtePP0Qjap9lNlNrqgCcOapGnvau8bIlkbCdOwU4dE6Qk58Tuq90E5gisNnqGIoYTw4ARvU9ZV2Tg37M5VhMHsu6SBgajcslrp7WEGyOMBAHgZ/oKRiEBSlF+dg2/hc0aS0HYlK/17NTD98arNlJIn7WgF2y+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312059; c=relaxed/simple;
	bh=pnt9ihcx9NGH6cmpY0DJowFRVYVLe704A9zzLDhDZlc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YzRbWzDGn7/4ZEbRWEOBSJ9fqPGJ/ZuAOGiI8xz8xkdLHNadEwoGlTAHNtA2dMIl01g6SOvCvnjpfN4OkPVkCwcn8+Msm3R41IIGl9+vUYz+iyktgH5drvRZWo7d/Ojh24ROKm/rqk2OTqsoJKwoolKgY43t/HeHDJn24ETku0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ceLlcXYF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pgKP6SnB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 13:47:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768312051;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwUr4AYoRcpN1BrSl/bZLAKMGLlJpzTMgE6RdjuTK60=;
	b=ceLlcXYFlLvyIjDokvR07MgGFMgA/29I1ne68NAQOB0yIxY+UNDvaraypobrH7a9jTJRWO
	E5gfAWc/dRqO0L0153aS+jfIK46xMXnT84d1beNfJqIfM55i2LM2q4aJUwKE5XVtXW7dSW
	jjG0QEWYHPUoSllkTVj2NCzNIqFhqqnxESHUzsW//G7K19MeQD3qExJSI7rAZqy88NMjjR
	SzK8j2iPKm+SN8MwmwLggsidH5UZIuYM7oLJa+WMnsVG8FxIQGEkseQ9LniU7IirqgqBWg
	LY0txkDTxUZQmYmTsWY7nqTkmOGQLnR21tUQOXKzQ8m7RYJq8GQ5CaFWO6ZioA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768312051;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MwUr4AYoRcpN1BrSl/bZLAKMGLlJpzTMgE6RdjuTK60=;
	b=pgKP6SnBebR5gC0h8VqTANYU1a5HFNxCFLRFvRZEBjA9DV0rBZ9heZKuoXIADg0CaKY4UQ
	+WW2f/yQ8qigw9Bw==
From: "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] parisc: Inline a type punning version of
 get_unaligned_le32()
Cc: Ian Rogers <irogers@google.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251016205126.2882625-2-irogers@google.com>
References: <20251016205126.2882625-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176831205022.510.18385399134954753660.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     feffe3a9d4b0d1672db4c16457f029f1c22b35da
Gitweb:        https://git.kernel.org/tip/feffe3a9d4b0d1672db4c16457f029f1c22=
b35da
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Thu, 16 Oct 2025 13:51:23 -07:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 14:46:00 +01:00

parisc: Inline a type punning version of get_unaligned_le32()

Reading the byte/char output_len with get_unaligned_le32() can trigger
compiler warnings due to the size read. Avoid these warnings by using
type punning. This avoids issues when switching get_unaligned_t() to
__builtin_memcpy().

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20251016205126.2882625-2-irogers@google.com
---
 arch/parisc/boot/compressed/misc.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/boot/compressed/misc.c b/arch/parisc/boot/compressed=
/misc.c
index 9c83bd0..111f267 100644
--- a/arch/parisc/boot/compressed/misc.c
+++ b/arch/parisc/boot/compressed/misc.c
@@ -278,6 +278,19 @@ static void parse_elf(void *output)
 	free(phdrs);
 }
=20
+/*
+ * The regular get_unaligned_le32 uses __builtin_memcpy which can trigger
+ * warnings when reading a byte/char output_len as an integer, as the size o=
f a
+ * char is less than that of an integer. Use type punning and the packed
+ * attribute, which requires -fno-strict-aliasing, to work around the proble=
m.
+ */
+static u32 punned_get_unaligned_le32(const void *p)
+{
+	const struct { __le32 x; } __packed * __get_pptr =3D p;
+
+	return le32_to_cpu(__get_pptr->x);
+}
+
 asmlinkage unsigned long __visible decompress_kernel(unsigned int started_wi=
de,
 		unsigned int command_line,
 		const unsigned int rd_start,
@@ -309,7 +322,7 @@ asmlinkage unsigned long __visible decompress_kernel(unsi=
gned int started_wide,
 	 * leave 2 MB for the stack.
 	 */
 	vmlinux_addr =3D (unsigned long) &_ebss + 2*1024*1024;
-	vmlinux_len =3D get_unaligned_le32(&output_len);
+	vmlinux_len =3D punned_get_unaligned_le32(&output_len);
 	output =3D (char *) vmlinux_addr;
=20
 	/*

