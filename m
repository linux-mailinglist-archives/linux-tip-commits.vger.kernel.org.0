Return-Path: <linux-tip-commits+bounces-1-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B4680ABB6
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 19:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531131C20922
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 18:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FA347A43;
	Fri,  8 Dec 2023 18:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WOoKNHyY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HmoS92ZV"
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD502133;
	Fri,  8 Dec 2023 10:12:59 -0800 (PST)
Date: Fri, 08 Dec 2023 18:12:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702059178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=i8RSaAj1FoNLBcjrSnL0NCPi3yBIbLyBZKtk3ha6yyA=;
	b=WOoKNHyYaV+P3u37nwZGlqNKqqQt8D87qAKNyrcp/h2n6dAda5LnodpvTgBHNzaWCdvDDb
	FzzZg9dQwhd8HBVSwrOvn3s2o4im7LaROz4a74PvKa92AvvMK/06FAVTVked2/zawLXjyp
	vrDB9wzqINnHF5sE3eKJrqMOXrq3AdhXRdZfhv2hCvg2e7FA6q5g94v6pDThdskCmJYdQr
	tdtI/Eut/vkaQVxuKzARJAAczdlrcYDFVbqS5eqQjpXPvPxtA3JBSRihmp5TwPk0ib2jBO
	Vhd9LC2u9F9qGbSsNdZJtZ5uOGOmTTi7WO641sD1l0vGk8UZHFFaxqNZNl1NsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702059178;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=i8RSaAj1FoNLBcjrSnL0NCPi3yBIbLyBZKtk3ha6yyA=;
	b=HmoS92ZVfedx998orBwSSrPw/uETEZQHm6yQYdjwOkKsfpnPMR++7150Fpj7fsbq5xbMF1
	4kaFo8UlZDa/M2Cw==
From: "tip-bot2 for Jo Van Bulck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Ensure test enclave buffer is entirely
 preserved
Cc: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Jarkko Sakkinen <jarkko@kernel.org>, Kai Huang <kai.huang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170205917777.398.5382474413072090594.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     a4c39ef4ed43103caef80029cd30427a9ff342d8
Gitweb:        https://git.kernel.org/tip/a4c39ef4ed43103caef80029cd30427a9ff342d8
Author:        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
AuthorDate:    Thu, 05 Oct 2023 17:38:51 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 10:05:27 -08:00

selftests/sgx: Ensure test enclave buffer is entirely preserved

Attach the "used" attribute to instruct the compiler to preserve the static
encl_buffer, even if it appears it is not entirely referenced in the enclave
code, as expected by the external tests manipulating page permissions.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Acked-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/a2732938-f3db-a0af-3d68-a18060f66e79@cs.kuleuven.be/
Link: https://lore.kernel.org/all/20231005153854.25566-11-jo.vanbulck%40cs.kuleuven.be
---
 tools/testing/selftests/sgx/defines.h   |  1 +
 tools/testing/selftests/sgx/test_encl.c |  9 +++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/sgx/defines.h b/tools/testing/selftests/sgx/defines.h
index d8587c9..b8f4826 100644
--- a/tools/testing/selftests/sgx/defines.h
+++ b/tools/testing/selftests/sgx/defines.h
@@ -13,6 +13,7 @@
 
 #define __aligned(x) __attribute__((__aligned__(x)))
 #define __packed __attribute__((packed))
+#define __used __attribute__((used))
 
 #include "../../../../arch/x86/include/asm/sgx.h"
 #include "../../../../arch/x86/include/asm/enclu.h"
diff --git a/tools/testing/selftests/sgx/test_encl.c b/tools/testing/selftests/sgx/test_encl.c
index 649604c..7465f12 100644
--- a/tools/testing/selftests/sgx/test_encl.c
+++ b/tools/testing/selftests/sgx/test_encl.c
@@ -5,11 +5,12 @@
 #include "defines.h"
 
 /*
- * Data buffer spanning two pages that will be placed first in .data
- * segment. Even if not used internally the second page is needed by
- * external test manipulating page permissions.
+ * Data buffer spanning two pages that will be placed first in the .data
+ * segment. Even if not used internally the second page is needed by external
+ * test manipulating page permissions, so mark encl_buffer as "used" to make
+ * sure it is entirely preserved by the compiler.
  */
-static uint8_t encl_buffer[8192] = { 1 };
+static uint8_t __used encl_buffer[8192] = { 1 };
 
 enum sgx_enclu_function {
 	EACCEPT = 0x5,

