Return-Path: <linux-tip-commits+bounces-4454-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4614FA6EBAE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7E9F16CB88
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57342561CF;
	Tue, 25 Mar 2025 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DdhrFUJi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/nOxB9SF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E48D255E30;
	Tue, 25 Mar 2025 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891701; cv=none; b=pHGhURT3HokxKJXAAU8XejXcTShGxQaXLXUU7bolTlx2ZnBYeIUK06nf+RcEg13ctQuQkydQ+0EAFt/8rkjuHyBWygSUQQrBzQ1VsL5UB4K8J5f24TcLmZnnHSVT0+ANaBt7DBrhuXKvmPEoAdJr+cYzNwPnEvgWfpcvDn36ENE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891701; c=relaxed/simple;
	bh=V7vrEOUI74dh15zODy2oiAtfxhrx8BBoQVZWU3f4XxA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hB/YpqZhEzFGQlAGQvCkJ1SB/BcXh7B66+EzHHGT42oV1+FBgwaSL0RSa04TzaTIVoPoBY96uQLe5VhC3A/QbG9JHrWuM1L0CRWXC3kjqFpd/tPpU6H/7eTRCOnd1PC8YwA0qnKIi0V20nhwc5KmBxfRvFQBgNHIy9vATyTA2aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DdhrFUJi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/nOxB9SF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:34:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742891698;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lH7k6Uezjus3BEvzfcPuhfxqTl2IJs8Uk+R0lj51uCY=;
	b=DdhrFUJirhdFg86rmc8YP27gPpVF4rWisMffCr10m8OvvWV1xXTpziIf6x3ewPl6iWnaTN
	S9CIkqzMZ+afXaJyfuK0Nx8y5iRp5nl+VkHvoXTkOkFy5tHbVr+9qx2tgkpVqMiNdcwQKZ
	OiGXS65XsEBkvf/+B+bkPiTniA1V2MFZeu88rz/TQVFYUZJrrOfiKQ0uA2/EuMn3AmnQWz
	lBY9aQAYqLlYvirsscD6apcaSp8LEeoBa2Uz5heITsrqS2jgjmIUEohwP6VrDFTFQZHCgz
	JeHLf6qAG1UMWp039JJ0P5e3t3yYr1l26OBQ6ETVvam+0lgPKLr6FEmC4NVM3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742891698;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lH7k6Uezjus3BEvzfcPuhfxqTl2IJs8Uk+R0lj51uCY=;
	b=/nOxB9SFLZPPBJB3dPaFtMPq5kwN52lZiL3DIVu8O2zEsiIPnOsWmD6Fs3ngVbkizpfjCc
	ZcqFgNJMYR/eR8CA==
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
Message-ID: <174289169728.14745.5614789618067784759.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     ea0d2a4c77d98e983b42f61790a0760a68983156
Gitweb:        https://git.kernel.org/tip/ea0d2a4c77d98e983b42f61790a0760a68983156
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:56:05 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:20:28 +01:00

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

