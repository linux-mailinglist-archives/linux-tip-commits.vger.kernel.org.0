Return-Path: <linux-tip-commits+bounces-3823-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CDAAA4CBB8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 20:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72F053A6D7F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9845023645F;
	Mon,  3 Mar 2025 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xh6l1+d7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SQP1GjSh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B6A23496F;
	Mon,  3 Mar 2025 19:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029183; cv=none; b=NmuvO3fiDTRB1fS5eDBSOp0NWoQk55o8VGWICHdWKFq0Qzo0O+Ug9kLmmg9nUwzZtyRHnDf/4jbYif9p7kVV8WR6JBqgo4XWyfZ7E98dHQnfe3EI8zUi2FF3ZZWV3UlAwyldvU7sufSpkiEYd4AUDLPZ2kLNy2JFoOStt8JezC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029183; c=relaxed/simple;
	bh=PEgStF3gfxSF7vjbqHlTBc+pJeFVKdkJKAoItqCg0kY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JEP9LakV2r8O0VDWPHf/FgQphWIzySff4FCxx3gEjv2ctce3CSCnZ4P0gAmX8EB3kRqvEesaLX6LU4e29y4CHTcgb1g54E0rrNUW+EwyMR2DzaFwo1J4wLzcYs5nqcvX4rmlGmI7LYwaucq7hKdyHYARm4+c1La9xWiAcILeHtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xh6l1+d7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SQP1GjSh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 19:12:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741029180;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JowWnB2oz4AY69r9imYX685OUef8ND5sLZO3ndeW6A=;
	b=xh6l1+d7RatLI/Eanc7xY2HxAlm3HA8UnimVkfDdNzwcV9oPM053R1MiNis9sBlLKbN8Gq
	7IJFkQcVTFLCKO4ASiFX8XunI5D227iT7GrcySi8hZPb5WWCgrUSFDYuZvrPtuqHwCyqDI
	U5DA+vgbWcZDsuneTcyWWUNr9g5oqHYsbGYPe/tjVNCK8h8aDKXafEHI4Ab2B3k7ayri8k
	9n3EoGj4wDJNuYq+yrmtR9BzOcXLyiqQwYQS8Y8xZLdy+q9vdI5O6opsa8svOBTyL+0A9C
	JJfvVBA0SIUjF6uf39ee9h2LEpTsOkL9QUkTOLTeWNY6SfQgLrp/sWdaQUWjdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741029180;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3JowWnB2oz4AY69r9imYX685OUef8ND5sLZO3ndeW6A=;
	b=SQP1GjShxnDlV5ReiujWzNTPiW9FPzmdRFpah1A14iLCK4H/kH6nzBjtRzYnk/JrdEZG55
	Ys2N7NZm0LOnRrCw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] tools/nolibc: add limits.h shim header
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Willy Tarreau <w@1wt.eu>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226-parse_vdso-nolibc-v2-9-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-9-28e14e031ed8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102917977.14745.15377173814779778758.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     5caaa0aa7c61513a2f606fd6d00fc29ae475ce9e
Gitweb:        https://git.kernel.org/tip/5caaa0aa7c61513a2f606fd6d00fc29ae47=
5ce9e
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 26 Feb 2025 12:44:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 20:00:12 +01:00

tools/nolibc: add limits.h shim header

limits.h is a widely used standard header.  Missing it from nolibc requires
adoption effort to port applications.

Add a shim header which includes the global nolibc.h header.
It makes all nolibc symbols available.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Willy Tarreau <w@1wt.eu>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Willy Tarreau <w@1wt.eu>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/all/20250226-parse_vdso-nolibc-v2-9-28e14e031ed=
8@linutronix.de
---
 tools/include/nolibc/Makefile | 1 +
 tools/include/nolibc/limits.h | 7 +++++++
 2 files changed, 8 insertions(+)
 create mode 100644 tools/include/nolibc/limits.h

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index a1f55fb..c1299a0 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -30,6 +30,7 @@ all_files :=3D \
 		crt.h \
 		ctype.h \
 		errno.h \
+		limits.h \
 		nolibc.h \
 		signal.h \
 		stackprotector.h \
diff --git a/tools/include/nolibc/limits.h b/tools/include/nolibc/limits.h
new file mode 100644
index 0000000..306d414
--- /dev/null
+++ b/tools/include/nolibc/limits.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Shim limits.h header for NOLIBC.
+ * Copyright (C) 2025 Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
+ */
+
+#include "nolibc.h"

