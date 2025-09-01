Return-Path: <linux-tip-commits+bounces-6399-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 907BBB3E722
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Sep 2025 16:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 161BC16653D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Sep 2025 14:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECCA34320A;
	Mon,  1 Sep 2025 14:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CSvLEncW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F3AOu4oV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70440342CA2;
	Mon,  1 Sep 2025 14:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736899; cv=none; b=dSR1Mndy/f7TA3ABkwfPU+Tu3QqLftVQm06rZkvIaAICMTD3J0wqWJ9WBofKVikeMKcsCaXMvaZtWo8uTe780Kf7AWk0cEn/oNLQ7sAhzsjzWWcu2AtVmvsmFYhF0ZXykyuxSDzsgWU/IXXecx92LxbyTb1CT+OMoOumnSnp5B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736899; c=relaxed/simple;
	bh=TzvBujZNzZfP0UxVZgtWG1/DFp/GVqhLOaMKevvgDMs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pptZ1xlqC/mgc8Lt28BJRqk0FcIrrH/ySlF6qaar9R0ygOr9Grw3FonDsRZIx6ThxcF94GwldZojiq7PEGBKrKV2cCYinW8hMwRMfEgdnx0CVx+TjKLhY3iRKmmqgoRQEatl+K19vSttuHYiCag3tBuHrz5ApocbxcjVYCqgwQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CSvLEncW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F3AOu4oV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Sep 2025 14:28:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756736895;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhQj1m459eY1K7hOj8xu43zSaG6TeZ5n3sh4d0Gg6YI=;
	b=CSvLEncWDZAGzW2z+48mQz4zXSjvgsj15u6a/dg9xjma+GsJf/nMGgIQB9Llwv9mIflMJv
	7y8FvaJnyIhk8bMQjIgJUc0OYW7Peo9SNjrAKvfezuwuO4CrlS3ah+1uCqCResNq/Bebcx
	UQuAoMRnR9ck2Hlv2IUMAi/cS2ipN3PhFIVHH7bnlnpg/mOJYdkWEdkp7kH/fA73sxxDoG
	vt2IEKq0eUfhR+aLXqRRrJhkisIHVHDeK+GgZGzIguP+V3e9dEiSDnfVRehxyiAMlOkJYO
	3w8wk+CwLDSC9lENlpNIJX8v2nT9Eji0gnAaB45OptuW4S8dBY51bYSdHp86fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756736895;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hhQj1m459eY1K7hOj8xu43zSaG6TeZ5n3sh4d0Gg6YI=;
	b=F3AOu4oVkEW4zek90g8avNFDqOdtluZ+jDX8xD0v+/rjX/M4bWegTIVg9VO3begu+GiYY/
	Rucp0SQH+Y4ZZTCw==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Remove the -g parameter from
 futex_priv_hash
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, andrealmeid@igalia.com,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250827130011.677600-2-bigeasy@linutronix.de>
References: <20250827130011.677600-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175673689465.1920.17988158000479586370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     2e62688d583809e832433f461194334408b10817
Gitweb:        https://git.kernel.org/tip/2e62688d583809e832433f461194334408b=
10817
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 27 Aug 2025 15:00:07 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 29 Aug 2025 12:01:17 +02:00

selftests/futex: Remove the -g parameter from futex_priv_hash

The -g parameter was meant to the test the immutable global hash instead of t=
he
private hash which has been made immutable. The global hash is tested as part
at the end of the regular test. The immutable private hash been removed.

Remove last traces of the immutable private hash.

Fixes: 16adc7f136dc1 ("selftests/futex: Remove support for IMMUTABLE")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Link: https://lore.kernel.org/20250827130011.677600-2-bigeasy@linutronix.de
---
 tools/testing/selftests/futex/functional/futex_priv_hash.c | 1 -
 tools/testing/selftests/futex/functional/run.sh            | 1 -
 2 files changed, 2 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/too=
ls/testing/selftests/futex/functional/futex_priv_hash.c
index aea001a..ec032fa 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -132,7 +132,6 @@ static void usage(char *prog)
 {
 	printf("Usage: %s\n", prog);
 	printf("  -c    Use color\n");
-	printf("  -g    Test global hash instead intead local immutable \n");
 	printf("  -h    Display this help message\n");
 	printf("  -v L  Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
 	       VQUIET, VCRITICAL, VINFO);
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/=
selftests/futex/functional/run.sh
index 8173984..5470088 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -85,7 +85,6 @@ echo
=20
 echo
 ./futex_priv_hash $COLOR
-./futex_priv_hash -g $COLOR
=20
 echo
 ./futex_numa_mpol $COLOR

