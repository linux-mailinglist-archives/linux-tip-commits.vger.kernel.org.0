Return-Path: <linux-tip-commits+bounces-3816-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABB5A4CBAD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 20:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18A73A00E2
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFC522CBE2;
	Mon,  3 Mar 2025 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jckpg3Ja";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nWuEwJ3T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DBE214A66;
	Mon,  3 Mar 2025 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029179; cv=none; b=DtDOV49rDp6fSLkqAhHhvRIrU+bRnFW7GhKJK+k3aDycisCiy3EfL9xJ4FThJyT5SDE4Wyd4U+ExKfpM1mVCe+5gRTp5muhDZSIHo4jTwb3Hf46I6dnNxE/fNoVYWUbTMN/OPS7KHyhaj7v3z0uv9u5Y4xybj5YQQY+40ZkY2kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029179; c=relaxed/simple;
	bh=+QOxQ5cXSBwQiG2dUzR9CDnZO6GVtut2b9kCIBlZTm0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Zy2+G96ISUvuUyR6MKGTho4k/VvpZ3W4/H1+zi0/l8iAXg3l1euKGiROO+HttXkbdXJvH7Bxug7EGWR0YCnC+6/sX0KVU0x2UcXWag1bgcXj2sLQmRIAGgCt/fPB1TfgWOYm1ba8CYCs+aK80yAZb44OzqK5PdjIan7l89e5+KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jckpg3Ja; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nWuEwJ3T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 19:12:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741029176;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iWIrCtaOS5gbNdQdtFOaRjlGkeWa+U/MDid/QVTyx4=;
	b=jckpg3Ja0iG5su0BymMNRyCCXZYppcGfWiGKmarjoPCBEv44vxC6iw9xwadaQb1Jid0sgL
	XXkkO2s1fWQdCiurSzU1n8GgAmSYVjfu9Ui3KCo7n8n0uF66rG4akOguxjwNejndja4Y/b
	ZpbS5fmJOlpmjc7N/mG+CCezKgf+WjqCINcPPfG0NcNteoijGvR5viWjNK969VbbdJIJEx
	tfgxmawcEeeVZZwUSxM1mQubwJ6EG2VhE8eZoIvEasghorSTfuOX++LaBCaFUDQy4DKaPN
	K2aWhY6dTHetUk3OUoaf7ZBQVi6KwLENTVdejJ6qZB1BPbqg7/IfWACw15AxMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741029176;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4iWIrCtaOS5gbNdQdtFOaRjlGkeWa+U/MDid/QVTyx4=;
	b=nWuEwJ3TSyRJjSPXLEFJsXrDJl8Qf37zTbZzme6JkqpnhuCsdiucPusGmS6n2n5DX3EN/i
	B+I0UZsxEvym+QCw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] selftests: vDSO: vdso_test_gettimeofday: Make
 compatible with nolibc
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226-parse_vdso-nolibc-v2-15-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-15-28e14e031ed8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102917580.14745.6072116244714414189.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     4f65df6a58b3de5132f978305c5f807ec3803943
Gitweb:        https://git.kernel.org/tip/4f65df6a58b3de5132f978305c5f807ec38=
03943
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 26 Feb 2025 12:44:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 20:00:13 +01:00

selftests: vDSO: vdso_test_gettimeofday: Make compatible with nolibc

nolibc does not provide sys/time.h and sys/auxv.h,
instead their definitions are available unconditionally.

Guard the includes so they are not attempted on nolibc.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/all/20250226-parse_vdso-nolibc-v2-15-28e14e031e=
d8@linutronix.de
---
 tools/testing/selftests/vDSO/vdso_test_gettimeofday.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/te=
sting/selftests/vDSO/vdso_test_gettimeofday.c
index 636a56c..9ce795b 100644
--- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
+++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
@@ -11,8 +11,10 @@
  */
=20
 #include <stdio.h>
+#ifndef NOLIBC
 #include <sys/auxv.h>
 #include <sys/time.h>
+#endif
=20
 #include "../kselftest.h"
 #include "parse_vdso.h"

