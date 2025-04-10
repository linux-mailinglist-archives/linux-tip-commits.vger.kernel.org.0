Return-Path: <linux-tip-commits+bounces-4820-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B6BA838FE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 08:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04BB465F9E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Apr 2025 06:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4F41FDE31;
	Thu, 10 Apr 2025 06:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cRRV4ues";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xYJbFi7L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5381BE251;
	Thu, 10 Apr 2025 06:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744265692; cv=none; b=A2n58mS/S2Wz5INkxl/7nOA/Z0C56Gv03PdDSGhMFekfK0b4DVoUsXNmETa+vwYL+7PwZQB8JKmgtLzBv5anqnHskt3YHDZnrLhymvBg+AnEsMqRT9QLYLWCO/i/16M0MiPes2jYR7qobY5lO+TOXx4dFcqoSCFxXj8GYol9vr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744265692; c=relaxed/simple;
	bh=mbx6ITtNLYAzsr/l+UdnT2YEpJ5YQ1IPbyXfHpbGrY0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j9RXSVw6aB2G3oyxj2Y2LTujrLSCeilYYAixiJgvELW77ypd3OZlmKqy1LkwufIgj6e/oJssQjT24/AxG9NKzOMt5qbZS0le21N6TKdidr/pTfp0+KDLnPyYOR5cBZcdZ1y1SzFFVMAZ4wzx+8VIksH4DaiWXA1FyubDB0MQ53o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cRRV4ues; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xYJbFi7L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 10 Apr 2025 06:14:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744265688;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZisqoqMU1Q5gHyNLzO+YmukOBCpyJ06A9NlZLs6fanQ=;
	b=cRRV4uesVI2uWj9a6yv2XbKTUY8Jb5CJsObcFWRxsiAYgWllgwPH9dwE5VzPC7IsSM/zhJ
	2XvOuIzfqasumlP54EohE2aoMStq/yLoayLsW0UcpPDTWQDq5oOLc755PQZO+NalE0+nE1
	JMU6kruvhd6Ne3lKMD/Dmv6lD1RR5Tf43KfT2pU8+kYw4ou1oirI29C7hGp8sv9HuIrWpa
	0wJBdYv8W6LyqM+ZYdDGwy1QLDWi1vroNzcC+48bVtoYvGj0QbYn+rJD8beiTpgs1BV6hg
	JQFkYi2Xy0hTjv5PXsuvfim2hShiS5E8TveIffbblRdIXDHqnj3lb8VTyRtLIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744265688;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZisqoqMU1Q5gHyNLzO+YmukOBCpyJ06A9NlZLs6fanQ=;
	b=xYJbFi7LPrnHXZEJUpGzGqLwA/txoenzRoVKmUKMtHDUoyLkerTfoqE2krTCyuAG+WIzU+
	9VixP8OPE1g6m5BA==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix false-positive "ignoring
 unreachables" warning
Cc: kernel test robot <lkp@intel.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <5eb28eeb6a724b7d945a961cfdcf8d41e6edf3dc.1744238814.git.jpoimboe@kernel.org>
References:
 <5eb28eeb6a724b7d945a961cfdcf8d41e6edf3dc.1744238814.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174426568347.31282.17971680226674649784.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     8af6f0fe9c4340ed97f0ba4f3f6cc7bb16558e87
Gitweb:        https://git.kernel.org/tip/8af6f0fe9c4340ed97f0ba4f3f6cc7bb16558e87
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 15:49:36 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 08:03:05 +02:00

objtool: Fix false-positive "ignoring unreachables" warning

There's no need to try to automatically disable unreachable warnings if
they've already been manually disabled due to CONFIG_KCOV quirks.

This avoids a spurious warning with a KCOV kernel:

  fs/smb/client/cifs_unicode.o: warning: objtool: cifsConvertToUTF16.part.0+0xce5: ignoring unreachables due to jump table quirk

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/5eb28eeb6a724b7d945a961cfdcf8d41e6edf3dc.1744238814.git.jpoimboe@kernel.org

Closes: https://lore.kernel.org/r/202504090910.QkvTAR36-lkp@intel.com/
---
 tools/objtool/arch/x86/special.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 403e587..06ca4a2 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -126,7 +126,7 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 	 * indicates a rare GCC quirk/bug which can leave dead
 	 * code behind.
 	 */
-	if (reloc_type(text_reloc) == R_X86_64_PC32) {
+	if (!file->ignore_unreachables && reloc_type(text_reloc) == R_X86_64_PC32) {
 		WARN_INSN(insn, "ignoring unreachables due to jump table quirk");
 		file->ignore_unreachables = true;
 	}

