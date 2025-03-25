Return-Path: <linux-tip-commits+bounces-4549-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D3EA70C9F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 23:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8013517A6BF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 22:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EBA26A1AF;
	Tue, 25 Mar 2025 22:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eokF8dgD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IZbC+Svf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B379626A0CF;
	Tue, 25 Mar 2025 22:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742940603; cv=none; b=BlUivxQlZXRl6vKc6K71NKOtzLjjOSgr+DjcO5wNjtBgIJri8IW0J9tceovdBS4ClUlv3+J6Kx2HXmZx9exIsFPU/RWnkq3MpvO3iTXwjd2g2wDMIas07AGhLO+UpeA2UjrC8GROn7lGhmI9aaeS2slT/MDrSxOGb1VuLS3Gza8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742940603; c=relaxed/simple;
	bh=HoYYo5mzVXH5i5WFk+wv9hbeSOanJGq6HuT+JZnciO0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J6z5rFMTCKuQPxVaK0aHLdHFQ5olGY8+BtPUe04iYwzs5bzaN3Rg/5Ux/vEipbj3SHTOCRh8x8bUPLlTgiToS84+7hKYOMrsqErDb+p1hDDUvCVgIqy+GAJ2J1knIWrjquGl7uNATmcwwNoHTl3CiyXA20apDdZLCEksAHNetXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eokF8dgD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IZbC+Svf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 22:09:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742940600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sf9Kvc5r7muvoNG4Rm904td4Lz2FJ+MUgIYxRWFA1eQ=;
	b=eokF8dgD6HkN8Fxu+RD6J/Yqx75fxq9NoE6X5nX/0AMB2UqjPAM74ii32ys8dqOYU4OGaa
	NTLW4+dkneo6MO6W+9bOHT0RZBu/FSYc+lTgAwhdrKQGXF0Gb5Wi5MKmrkUFiZghwNMg8t
	5TEhCV2tZvcmgD0u2QmJ89PD3neSonTOqNjh/ZOspQdMOTutlpbF4uiRWhBh0Q8UG9zvKP
	1uP+Abg0cPTBuhvy5elUv1ORJ8TkZOnk9wOvydI8PCmFrrjtMnn2fsNsjUCYYjQiQg8qkc
	SJBmxTUJwaaXTRFaiYnZ0MpT71+RLoSasESdsvKlqh158ES2RxkOFUei6W+NXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742940600;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sf9Kvc5r7muvoNG4Rm904td4Lz2FJ+MUgIYxRWFA1eQ=;
	b=IZbC+SvfDlPKMhLXU63bCxldnhnPbm/o1bMJFBaGI30ZpdfTrvPYc1nADcDWRUm2xwLjef
	cKcphbSFsHoq9wCA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool, nvmet: Fix out-of-bounds stack access
 in nvmet_ctrl_state_show()
Cc: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <f1f60858ee7a941863dc7f5506c540cb9f97b5f6.1742852847.git.jpoimboe@kernel.org>
References:
 <f1f60858ee7a941863dc7f5506c540cb9f97b5f6.1742852847.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174294059921.14745.13913646647268973086.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     107a23185d990e3df6638d9a84c835f963fe30a6
Gitweb:        https://git.kernel.org/tip/107a23185d990e3df6638d9a84c835f963fe30a6
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:56:05 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 23:00:15 +01:00

objtool, nvmet: Fix out-of-bounds stack access in nvmet_ctrl_state_show()

The csts_state_names[] array only has six sparse entries, but the
iteration code in nvmet_ctrl_state_show() iterates seven, resulting in a
potential out-of-bounds stack read.  Fix that.

Fixes the following warning with an UBSAN kernel:

  vmlinux.o: warning: objtool: .text.nvmet_ctrl_state_show: unexpected end of section

Fixes: 649fd41420a8 ("nvmet: add debugfs support")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/f1f60858ee7a941863dc7f5506c540cb9f97b5f6.1742852847.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/oe-kbuild-all/202503171547.LlCTJLQL-lkp@intel.com/
---
 drivers/nvme/target/debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index 220c739..c6571fb 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -78,7 +78,7 @@ static int nvmet_ctrl_state_show(struct seq_file *m, void *p)
 	bool sep = false;
 	int i;
 
-	for (i = 0; i < 7; i++) {
+	for (i = 0; i < ARRAY_SIZE(csts_state_names); i++) {
 		int state = BIT(i);
 
 		if (!(ctrl->csts & state))

