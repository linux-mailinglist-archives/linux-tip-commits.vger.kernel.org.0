Return-Path: <linux-tip-commits+bounces-7979-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DBED1CFB6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 09:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 814F33048D99
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 08:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2DA379972;
	Wed, 14 Jan 2026 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qX/EVMq1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kugwrnyC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C298937A487;
	Wed, 14 Jan 2026 08:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768377693; cv=none; b=fHraG/HfjtuMe8c0cokLVtXJEtih63OqyE5N96/xpiD/fx7/yvzPzgVafbALU9VaZkZJ2qBlSCEzonESc+6nv7KyzYX2tKRW6FwEtbRqMtsWcduHnvrDirlP5Os1rCY312yb0LSp2IdBzXNw/Vhmx/0NloTzE1k/GLVKYnYXpZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768377693; c=relaxed/simple;
	bh=aYMInI4oWtPHvCofOGBt6YtkYasB7/0PIUWmXY5OH/M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eKlujLjEsjB0J1Qfmc8K7n+fyE/O8VP1Bh+NKYKgMR9yVMmYXaZ5m53YYS6BceHawPyZIosnvIWsSunVshHokDT6id6nUbhW9W13zHiWy0Z79Qx/N/uQ274lZcVNX6JBZhrk7SfcC0xBJcc7ZwF8iBy61CGJvESqgSoS9MZ0/IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qX/EVMq1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kugwrnyC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 08:01:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768377682;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpAQdT4ujTMTWVCaIjPgxIk9022STEJF8S9EbpeqZfY=;
	b=qX/EVMq18YpY2ChpaauXNjkNOIBdwCz7IJBwMAsvyZAZ+UbBbx/tC9WDAgN+LROnrxrxHJ
	Wg2R1szhJNGAT1aeC+Ub6soePDrVrzLqfJOu20YfUgRLRWvPRceizZwyCJg6IyNJsz06uW
	7w1QSfC5mLmUfUNWrciREbQiujE7NXasBwwa0vq3A7TkKVCfQ37fWGGWoxvOH1vZg0USun
	l8hJ9eysOEECWLqUKdTvRvMSWUGlliB1pF6zu+Kue7p68wN44UcUNKeePnVbiiHMgF/yxM
	uAkn0s+s+UMDsfaoyaKMpX39XWqkQhQ8pxQkay+ED2KM3N++lA3ueGuV8dO6Kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768377682;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cpAQdT4ujTMTWVCaIjPgxIk9022STEJF8S9EbpeqZfY=;
	b=kugwrnyCAEKed+MJjqDsKMz+dMEnW/KfSRzRzpdXIwjIhoW4MaXTGgsMoOjjZ3PnhTretR
	V7sMp56oozGOO3BQ==
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
Message-ID: <176837768116.510.12611061936192435922.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     df0f9a664be55a8529362a1ada847a19a91e4807
Gitweb:        https://git.kernel.org/tip/df0f9a664be55a8529362a1ada847a19a91=
e4807
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Thu, 16 Oct 2025 13:51:23 -07:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Wed, 14 Jan 2026 08:56:41 +01:00

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

