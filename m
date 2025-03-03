Return-Path: <linux-tip-commits+bounces-3818-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7965A4CBB0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 20:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0139F7A6CCC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0F022FF4F;
	Mon,  3 Mar 2025 19:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GXywD6ob";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L+4Lruvx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FE3215041;
	Mon,  3 Mar 2025 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029180; cv=none; b=dho3g/mQcU1HVrFC1p24lh+X7yHNqhtdD7CHs33MovdVYP81Psybx/qfDvfARscYDe6f0kQlm9JbLoebCcETZnIfGyfqblbg+sNHh6A0Nq5j2mhZmmgjDLJQIEGSwAg4SezpojpjNCCvlbAwsOTr0jt0cPm/N5b2fnh8/LlAYbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029180; c=relaxed/simple;
	bh=GHfuiebOnouFDIao1+9eKUL9ZGKuZyDbaj2ELUGBOSU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aSw/6bfBWsG2ZTQZk7h87+TS5t6tkMJKfWT/f0+tOZGGYrBSoVv3MQr0gbJoE5eGMkcFxS3jKZs2gu0N2V9gP6PjFGt48uTltRo7Ozsady2L8/q5PHDn4LZJGBhdyV+tE6SuOs+cT+Fvgcn4Jj5n6YYlD9djPcxUVIMbEfFQVwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GXywD6ob; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L+4Lruvx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 19:12:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741029177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRsU+Sbd+pNWWnatbtsxvTOj+oCWDDNJozI//MkL/UM=;
	b=GXywD6obFsD6vcerkmo1M+sbGfD9AXnknudWma101j1h0SHgxR/VbWjZagR+CYe2zKckud
	3BpEME35AQPopGsrC8lIYyIN+4zbDPHf2yUU6QJT1DhF72NGGoPO6/Y/CJ9rGvIFL8fl9X
	uNXM0n+amHJ9FSlk1Ds6k59dkH7i6r8u8P5wbU3cSV54jws0sVe54KH7br4SFpmyUyu4R0
	b2LV7zuYwJKoz8oIe19Lwvtx1r1/tDG4F2JM1zNO7J/S0y88LCPOn3q5/28FFF/yLXJDe8
	foiB7GmG8JRqUbOUpnptBOefiff7RPPmrAle929O5lfQMdU0x1cbEbnfaFdZgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741029177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CRsU+Sbd+pNWWnatbtsxvTOj+oCWDDNJozI//MkL/UM=;
	b=L+4LruvxTzcnWRjam7nqHwuBCPDi2JDu3QHjTjvzjBtbgctaInnhObTCp6HexzkO4vJqaS
	m/J42yJwRkG1inDA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] selftests: vDSO: vdso_test_gettimeofday: Clean up includes
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226-parse_vdso-nolibc-v2-14-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-14-28e14e031ed8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102917647.14745.6834700558249401461.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     97a88141241fcf3d1e54a120afefea04fbd1a484
Gitweb:        https://git.kernel.org/tip/97a88141241fcf3d1e54a120afefea04fbd=
1a484
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 26 Feb 2025 12:44:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 20:00:13 +01:00

selftests: vDSO: vdso_test_gettimeofday: Clean up includes

Some unnecessary headers are included, remove them.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/all/20250226-parse_vdso-nolibc-v2-14-28e14e031e=
d8@linutronix.de
---
 tools/testing/selftests/vDSO/vdso_test_gettimeofday.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c b/tools/te=
sting/selftests/vDSO/vdso_test_gettimeofday.c
index e31b18f..636a56c 100644
--- a/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
+++ b/tools/testing/selftests/vDSO/vdso_test_gettimeofday.c
@@ -10,8 +10,6 @@
  * Tested on x86, 32-bit and 64-bit.  It may work on other architectures, to=
o.
  */
=20
-#include <stdint.h>
-#include <elf.h>
 #include <stdio.h>
 #include <sys/auxv.h>
 #include <sys/time.h>

