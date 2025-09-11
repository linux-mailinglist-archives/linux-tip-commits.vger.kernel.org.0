Return-Path: <linux-tip-commits+bounces-6566-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1B6B52E60
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 12:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A469648010F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 10:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26FA314A8D;
	Thu, 11 Sep 2025 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jEZ8otLm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tKsWdMyj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62A4313E2C;
	Thu, 11 Sep 2025 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586545; cv=none; b=Pz4SbKsO5oAgWEUCkCLjlfipbq8UOSBG+lGUkabQrrSI/0B1l1HCvi2iJ/Lcj9BGzbkM461HE2cjZyyS5O7QuTNZD2NMzsE6ozK+/1nVrAipRi3BVgzc3F4l8h7Prc9cYUK5o1eqE7S9tfW9PC33294c4Su43pDuku7VQWWqJa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586545; c=relaxed/simple;
	bh=rPhj1AM5Q5TVakSIW3Jo0lrmR8NFKWKn3qdbnOoVQ/o=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=o+NH7g5jLYboLRf46LF+lctjVfL405yRlTXQKBJHt69XaV+Lx0PvQdYi/oB8ylP7Pk1G4jtg6oFEMOXvkefpGugrYSPn8YOZun8+U+Hu/H9B3sJnFEOqIQAr++eEp3t+j7AVxpFuGfCWXsGJYwkFYn7TXUj8cI1aaU2bv4qQG2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jEZ8otLm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tKsWdMyj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 10:29:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757586542;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YwTzikQUVCXD+LlKDopQyFxlQ8ZQtNErBjjZRwBjaxQ=;
	b=jEZ8otLm46Fzq3Nsp8F79fZlnF7uLmzdNdtUUIUqTVbsaIGlJHQCFWQ2HOhpvyQLXpQrV1
	9inRmz31YTrVCbizgn6M3+1Ty10sD2a/IEGNY2k7uFq5QcSu0dkg1Plpx9BSI9TN7AWVl8
	1X9Cf1L2jUuQnmje9y0in6tf2tByd+tczd8VRzoEwqUuK6XNdEpPkjvbUf3LxdbRUziuPq
	dsueLgiSlJKyhmCSBzGQk4oPQWElg1iYlsIU15INY3D9Icn1U7sPeUFI0dYzwgxQ0EhNYC
	kSZfbrdUZBTPpN4FDWZAZfebGUYiqr0UFIlFfQlpqqo8PAhy8WhEfPfQangJiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757586542;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=YwTzikQUVCXD+LlKDopQyFxlQ8ZQtNErBjjZRwBjaxQ=;
	b=tKsWdMyjGGrlZN3UXOOJBBGNp3vYaiNf3xgSFKbnjSZOumGzkkrtxKS+o9jNmw7EpNbsup
	o9hvdiC+3UfKePAg==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Do 'UNKNOWN' vendor check early
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Tony Luck <tony.luck@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175758654121.709179.17450649308580079896.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     a46b2bbe1e36e7faab5010f68324b7d191c5c09f
Gitweb:        https://git.kernel.org/tip/a46b2bbe1e36e7faab5010f68324b7d191c=
5c09f
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 08 Sep 2025 15:40:33=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 11 Sep 2025 12:23:03 +02:00

x86/mce: Do 'UNKNOWN' vendor check early

The 'UNKNOWN' vendor check is handled as a quirk that is run on each
online CPU. However, all CPUs are expected to have the same vendor.

Move the 'UNKNOWN' vendor check to the BSP-only init so it is done early
and once. Remove the unnecessary return value from the quirks check.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.=
com
---
 arch/x86/kernel/cpu/mce/core.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index a8cb7ff..515942c 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1977,14 +1977,11 @@ static void apply_quirks_zhaoxin(struct cpuinfo_x86 *=
c)
 }
=20
 /* Add per CPU specific workarounds here */
-static bool __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
+static void __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 {
 	struct mca_config *cfg =3D &mca_cfg;
=20
 	switch (c->x86_vendor) {
-	case X86_VENDOR_UNKNOWN:
-		pr_info("unknown CPU type - not enabling MCE support\n");
-		return false;
 	case X86_VENDOR_AMD:
 		apply_quirks_amd(c);
 		break;
@@ -2000,8 +1997,6 @@ static bool __mcheck_cpu_apply_quirks(struct cpuinfo_x8=
6 *c)
 		cfg->monarch_timeout =3D 0;
 	if (cfg->bootlog !=3D 0)
 		cfg->panic_timeout =3D 30;
-
-	return true;
 }
=20
 static bool __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
@@ -2240,6 +2235,12 @@ void mca_bsp_init(struct cpuinfo_x86 *c)
 	if (!mce_available(c))
 		return;
=20
+	if (c->x86_vendor =3D=3D X86_VENDOR_UNKNOWN) {
+		mca_cfg.disabled =3D 1;
+		pr_info("unknown CPU type - not enabling MCE support\n");
+		return;
+	}
+
 	mce_flags.overflow_recov =3D cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV=
);
 	mce_flags.succor	 =3D cpu_feature_enabled(X86_FEATURE_SUCCOR);
 	mce_flags.smca		 =3D cpu_feature_enabled(X86_FEATURE_SMCA);
@@ -2274,10 +2275,7 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
=20
 	__mcheck_cpu_cap_init();
=20
-	if (!__mcheck_cpu_apply_quirks(c)) {
-		mca_cfg.disabled =3D 1;
-		return;
-	}
+	__mcheck_cpu_apply_quirks(c);
=20
 	if (!mce_gen_pool_init()) {
 		mca_cfg.disabled =3D 1;

