Return-Path: <linux-tip-commits+bounces-6690-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D70B8CD02
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 18:27:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87CC8169EDA
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 16:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228833002DD;
	Sat, 20 Sep 2025 16:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gskf8Z0Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oqzE7VeZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520B018EFD1;
	Sat, 20 Sep 2025 16:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385666; cv=none; b=NW/AyI3V5pMrQFoMW5lq3SQcxIuHYPidN7mPMEaOCzRJKS6SdJJyfiknna05c8GubEoX9s3ddmxOc2/OSgcCHjI1ro0/5Px1bWqsw4bgxn7BdVD9WwBH389PbGDuNqV5l+HojLoPNKDRVDUv1PwTK+6a25bFS6Zy4aDK3KXo7Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385666; c=relaxed/simple;
	bh=NoXKtr5nRX8ybOxmmivn+o55HWRLpTgYA7QCOlueWWU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rJzJgLCL9Dhsq2A5ev0ltNIylARESBfvrxYaFrWqiCuocoXlQdrLTSenEJj5xax6Wo9SxIfb0XYVHcicS3LfKSu5XBTNWWo3nZ4c0w00mXhCWuODs+BkvlDUzLyfsweqsWyMzqKVXohiluOEiQ1pZFflFauH76f2HXYzNLiTS3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gskf8Z0Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oqzE7VeZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Sep 2025 16:27:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758385662;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47S1mAh4qmFyUTNUudV1PS29XADlHVG1/ASE1yZ963s=;
	b=gskf8Z0Y6EnOFjvUq/5mQXOEtmnS0HxL304XwBFoNTCfYI55+AJT9L0T3i0gYbI/mvaHlu
	DSJ/yeT3w2GKbMK4UPI/r3q3l1pQ1F+dgvK/cDWyASWI2iCdsV/5o4aEgFPzmlaeAUwHFy
	hT6ZbnLeiv0DPooeyNegnK4UwziF9PH/v0hnKfG1wBJvYmxmgl6ARtcoBwc6XY8tSO88/r
	kx6gVxeg+nYhAs4QZs25GYir8FPBCG8yb8/ynlOP4MOP0P/EtUBL767ncrUkGg8kLICiDc
	e4imVxuac/WUZzltyOBIiKL6DlcCkWWKk7X88BL1lIID8qVVQsQwRMhDsOfdzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758385662;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=47S1mAh4qmFyUTNUudV1PS29XADlHVG1/ASE1yZ963s=;
	b=oqzE7VeZ4U284k+tXI5D6ov0ElrB1YIobbBPDq4kKBW6ok9VKiSw4dSzKl89DHKJxw420O
	vk7f7fPp24uCTqBA==
From: tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/futex] selftests/futex: Drop logging.h include from futex_numa
Cc: andrealmeid@igalia.com, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20250917-tonyk-robust_test_cleanup-v3-14-306b373c244d@igalia.com>
References: <20250917-tonyk-robust_test_cleanup-v3-14-306b373c244d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175838566105.709179.9599719950799213794.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     b257d91c4db5bafcc3f67eab120e75bda4f61137
Gitweb:        https://git.kernel.org/tip/b257d91c4db5bafcc3f67eab120e75bda4f=
61137
Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
AuthorDate:    Wed, 17 Sep 2025 18:21:53 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 20 Sep 2025 18:11:56 +02:00

selftests/futex: Drop logging.h include from futex_numa

futex_numa doesn't really use logging.h helpers, it's only need two
includes from this file. So drop it and include the two missing
includes.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/futex/functional/futex_numa.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa.c b/tools/te=
sting/selftests/futex/functional/futex_numa.c
index f29e4d6..e0a3351 100644
--- a/tools/testing/selftests/futex/functional/futex_numa.c
+++ b/tools/testing/selftests/futex/functional/futex_numa.c
@@ -5,9 +5,10 @@
 #include <sys/mman.h>
 #include <fcntl.h>
 #include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
 #include <time.h>
 #include <assert.h>
-#include "logging.h"
 #include "futextest.h"
 #include "futex2test.h"
=20

