Return-Path: <linux-tip-commits+bounces-3538-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD455A3E88C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 00:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BD7178121
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Feb 2025 23:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8247D20D504;
	Thu, 20 Feb 2025 23:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b885VKnk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aEHPU3cz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF552B9AA;
	Thu, 20 Feb 2025 23:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094366; cv=none; b=icA7Aw9e5CpHYRvyAff7seJS32aenYFalIzIaZmHBANir4Hz6OUnz1BOmzG4zPOz/obarhUtKyTRfEkA8GnPx85hf38+ft2ZQrM3gRDsB38Km7xwaLZvsYeqCPAvE4Miv83nqwEAKGu/N5kp7oK+16VyNLLL+ciYQR+7oa3RX94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094366; c=relaxed/simple;
	bh=+nf1EcKnac5t8Vrhz2jYyT2lBWSLyiK8hgtfDB21mXQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=SSHDokmrTD2dCCbFhrTkdhosIRTcf1jx3ZO667veuwq/h4ui6DCZay+RlpNxs2b6Y5WzJ1TDKOSVVRE/EyaLDAvf/W50AmgLpFAmNi8RcHBefnif3SGFb05YhQvbMsRz3lxX8XLLxIwoMo7N0HXQDulNQdvpNkl+Zy0uTGpOdWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b885VKnk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aEHPU3cz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Feb 2025 23:32:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740094362;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=+MWq1NJY7fh5Cm36mR754lGRJLrn5yWoa4maosoIVbs=;
	b=b885VKnkwJv7ToywskyolNOlXS7FwimkvqmvN9NrsuGAycymqxILjVtIk0OJFhJJPIDTmV
	KfJTWPgxgI+l+aoZv/5xJhIFCjIglvqgPfG4sO0U/MZK3ZhTdxWtTQ7PU3rBYUMJw9y+C/
	nDam0XrI7LB/jt6KZNnir6dmT/NbFuvdfaMT1mD7KbHp3In0IZeFmiMpYFBrDUh7T3fOxH
	ZxdhdQOVArXcvd+YLBrQDG846LgrtCBIkQ/KPO37Ge/PDT+zV+x6VBhSoDk9mq6mbcoBA8
	UYprqCFk/ziuiteUjB5fsv2Z9vs2mq5j2/h9ZLWmA+49lcz1YU+oynJ57tHZvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740094362;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=+MWq1NJY7fh5Cm36mR754lGRJLrn5yWoa4maosoIVbs=;
	b=aEHPU3cz6B+3zLI/s4FN18ut8Eq7U20V8e7TFFHpiOfE9+1W7cSSqYvutUuZA/m7vdZrjN
	cSbrODMTsuj4B2AA==
From: "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] MAINTAINERS: Change maintainer for RDT
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Tony Luck <tony.luck@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174009435948.10177.5732078884302490581.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     b522f180ee2b264b771fcbd0ab67d84cdd9e580d
Gitweb:        https://git.kernel.org/tip/b522f180ee2b264b771fcbd0ab67d84cdd9e580d
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Fri, 31 Jan 2025 11:07:31 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 20 Feb 2025 15:23:50 -08:00

MAINTAINERS: Change maintainer for RDT

Due to job transition, I am stepping down as RDT maintainer.
Add Tony as a co-maintainer.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Acked-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/all/20250131190731.3981085-1-fenghua.yu%40intel.com
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index feed152..d1cbaeb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19779,7 +19779,7 @@ F:	net/rds/
 F:	tools/testing/selftests/net/rds/
 
 RDT - RESOURCE ALLOCATION
-M:	Fenghua Yu <fenghua.yu@intel.com>
+M:	Tony Luck <tony.luck@intel.com>
 M:	Reinette Chatre <reinette.chatre@intel.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported

