Return-Path: <linux-tip-commits+bounces-7955-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E83D19274
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 14:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47273301AB7B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 13:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B0F392B70;
	Tue, 13 Jan 2026 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tQw5nwtb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jRrcxpXm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F0D39283C;
	Tue, 13 Jan 2026 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312065; cv=none; b=XrE+Gox504cO0tBjyOxiOeNHAgE0fpkA76DD/OkndWF6UxqoMsuU8zWS6s4oT5dDGeCdbm0szs/Ml8DIdRGeU7esLY6vQoTpyjFiwZWSVbVzdu89eFBB4/hMmXiF1dlKLI7UAMb88EdlKt4mGcA9pagnGoE0I7mxkISse/YKwSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312065; c=relaxed/simple;
	bh=b9c39yrpETpG+KkVowrGdQOI48FKCmhMvnPf8nOptBk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QFVyuJ5zRAH3IYK/WGK2NEYJcaYwi3PkJdGmaB+aNQqnTiKusAIpvXlHOsEkzTBQmHqvgN2wQp3+MqVgaG+T5MToQbGeCQ7VVbV9cEJ4EvVqtpA7/zYJ9uRf5QinqNfOCbz6q3HpomZbSslAXeicfQZOs0f/u91wnQu4wXlib30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tQw5nwtb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jRrcxpXm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 13:47:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768312060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmDv0X2f0d1K0j5o7Rl0S+9rNNyfUdBSqZQ7FBg3DTE=;
	b=tQw5nwtbCJwQxl0ITwW+4G0QevR+aet2TOGcVsvdkSF9Wogfo3IgTLa373v3pp98GG757c
	dqGF3zbYSffDWYPDcNFtnWHZyel5A867KB+wrBKBt2L050Hv7a4TdBzPGKnfw4MC7Jo7vl
	QPzlmj8p0WXmzvslYgUHJ/O2uU1vuZIXv2DOvi0I8jud+ibe/zM7MAdODcwQ4+LYWcpA7X
	Ag8a8/Qv4XhqnxsZ1y+rblHJuTJuhcBmXnAsURguSuRC6zFifxa8e29ClTbxYb48jajM92
	+YtSsTvdx1hk5yDl/velXQ4D3WsETN15C05DoA22JrJ5Xp0SPBU1yCxzHW48Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768312060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PmDv0X2f0d1K0j5o7Rl0S+9rNNyfUdBSqZQ7FBg3DTE=;
	b=jRrcxpXm5uI8ZjDch+kMItWQYkoRCw3uaDDZmVkkzLlLiJ7wJClXXM9U0ZAC3zYyJXrVCs
	qxGDiFi4ivyHnuAw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] selftests: vDSO: vdso_test_abi: Add test for
 clock_getres_time64()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251223-vdso-compat-time32-v1-4-97ea7a06a543@linutronix.de>
References: <20251223-vdso-compat-time32-v1-4-97ea7a06a543@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176831205878.510.3437388750079795458.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     4e6a2312986d437cc22805b9e08f86b15fee0318
Gitweb:        https://git.kernel.org/tip/4e6a2312986d437cc22805b9e08f86b15fe=
e0318
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 23 Dec 2025 07:59:15 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 14:42:23 +01:00

selftests: vDSO: vdso_test_abi: Add test for clock_getres_time64()

Some architectures will start to implement this function.
Make sure it works correctly.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20251223-vdso-compat-time32-v1-4-97ea7a06a543@=
linutronix.de
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 53 ++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/sel=
ftests/vDSO/vdso_test_abi.c
index a75c12d..b162a4b 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -36,6 +36,7 @@ typedef long (*vdso_gettimeofday_t)(struct timeval *tv, str=
uct timezone *tz);
 typedef long (*vdso_clock_gettime_t)(clockid_t clk_id, struct timespec *ts);
 typedef long (*vdso_clock_gettime64_t)(clockid_t clk_id, struct vdso_timespe=
c64 *ts);
 typedef long (*vdso_clock_getres_t)(clockid_t clk_id, struct timespec *ts);
+typedef long (*vdso_clock_getres_time64_t)(clockid_t clk_id, struct vdso_tim=
espec64 *ts);
 typedef time_t (*vdso_time_t)(time_t *t);
=20
 static const char * const vdso_clock_name[] =3D {
@@ -196,6 +197,55 @@ static void vdso_test_clock_getres(clockid_t clk_id)
 	}
 }
=20
+#ifdef __NR_clock_getres_time64
+static void vdso_test_clock_getres_time64(clockid_t clk_id)
+{
+	int clock_getres_fail =3D 0;
+
+	/* Find clock_getres. */
+	vdso_clock_getres_time64_t vdso_clock_getres_time64 =3D
+		(vdso_clock_getres_time64_t)vdso_sym(version, name[7]);
+
+	if (!vdso_clock_getres_time64) {
+		ksft_print_msg("Couldn't find %s\n", name[7]);
+		ksft_test_result_skip("%s %s\n", name[7],
+				      vdso_clock_name[clk_id]);
+		return;
+	}
+
+	struct vdso_timespec64 ts, sys_ts;
+	long ret =3D VDSO_CALL(vdso_clock_getres_time64, 2, clk_id, &ts);
+
+	if (ret =3D=3D 0) {
+		ksft_print_msg("The vdso resolution is %lld %lld\n",
+			       (long long)ts.tv_sec, (long long)ts.tv_nsec);
+	} else {
+		clock_getres_fail++;
+	}
+
+	ret =3D syscall(__NR_clock_getres_time64, clk_id, &sys_ts);
+
+	ksft_print_msg("The syscall resolution is %lld %lld\n",
+			(long long)sys_ts.tv_sec, (long long)sys_ts.tv_nsec);
+
+	if ((sys_ts.tv_sec !=3D ts.tv_sec) || (sys_ts.tv_nsec !=3D ts.tv_nsec))
+		clock_getres_fail++;
+
+	if (clock_getres_fail > 0) {
+		ksft_test_result_fail("%s %s\n", name[7],
+				      vdso_clock_name[clk_id]);
+	} else {
+		ksft_test_result_pass("%s %s\n", name[7],
+				      vdso_clock_name[clk_id]);
+	}
+}
+#else /* !__NR_clock_getres_time64 */
+static void vdso_test_clock_getres_time64(clockid_t clk_id)
+{
+	ksft_test_result_skip("%s %s\n", name[7], vdso_clock_name[clk_id]);
+}
+#endif /* __NR_clock_getres_time64 */
+
 /*
  * This function calls vdso_test_clock_gettime and vdso_test_clock_getres
  * with different values for clock_id.
@@ -208,9 +258,10 @@ static inline void vdso_test_clock(clockid_t clock_id)
 	vdso_test_clock_gettime64(clock_id);
=20
 	vdso_test_clock_getres(clock_id);
+	vdso_test_clock_getres_time64(clock_id);
 }
=20
-#define VDSO_TEST_PLAN	29
+#define VDSO_TEST_PLAN	38
=20
 int main(int argc, char **argv)
 {

