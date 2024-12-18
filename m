Return-Path: <linux-tip-commits+bounces-3083-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 449719F5C02
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 02:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EDDE16C1F1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 01:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03F313790B;
	Wed, 18 Dec 2024 01:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qZ8GNAHu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rQb98Bew"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2FB78C9C;
	Wed, 18 Dec 2024 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734483621; cv=none; b=IqhHDZG00F50OQoyPz8b5bq63oubsJB4Q1f2lPYRcowG2l8FvqkND5XBa2MDt+GJSPFU0CX5jCzhCxuKszO8n1qX39CU+RQFZWrBvAaJA6o2IhynyfvVxLoI9rZxpZ0GpUIUCimVyvlIO6yWUKm7QYMCOWnDzf5kTHPlApBE6jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734483621; c=relaxed/simple;
	bh=pl+4ClTw+/iujlO7RP5EOKhrVB8DreMp8yarOh0MtSQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=lGElxdL5SetNf/wF1RRJifYY7AOUbzOpyq32CssHKkOvbKjfNIJy6SkwHkbQCJNVMtWd4mnrrtsvphO+gHskRskTIu25hkM1ZdTcB2/C74txFZi3Cb3W1RJsP/7eu+46+LzXKJqM7KDjp+bFUw+NDB6V0HXpNM5rau+yQ9PPI4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qZ8GNAHu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rQb98Bew; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 01:00:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734483617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=in2bjx3EKNhtMHi0grNr1kRNMQoASB5CmwM1D6Ufc6k=;
	b=qZ8GNAHukNrcCBSi/th+C9N5SsFKjYfWp4bX3KjqCSAycXQ6CFyjOLIU0fwR8jGODXhlm8
	T+mOFhcPh/6v5K92wloY5gghq0SIAJGo5J4hYknyES2pja6QYR+xCtMLy2QfJu/RXJEkKX
	8GHY+u6aQk5XwdX7PjmompAshFMCdzhStmqDe0yhsSkXgmqnymEE1MlcZM8wW5fgTvrL95
	Ef0bMGs1arFro5DuyCnTU7S++i2Zkrx49hUq840dfpfTYZlikG3HxQIyxSnZurM7am6N+c
	t/e5GsElCWaUG/9aMFs6D9FeCCJZUiZo80tQAGWmsXBosc7ItC95wtwd+ngqZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734483617;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=in2bjx3EKNhtMHi0grNr1kRNMQoASB5CmwM1D6Ufc6k=;
	b=rQb98BewhQwkT0NpfWFejHneApFeHvuFrYkT4sSYCIepMPn9nn2eVpPqBpOolQQKLc/h7T
	Yc5OH9UkisTGCFBA==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Introduce new microcode matching helper
Cc: Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173448361649.7135.10452817171660944718.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     b8e10c86e674eb19e0e53dcf4fa3e71cba1e0c1c
Gitweb:        https://git.kernel.org/tip/b8e10c86e674eb19e0e53dcf4fa3e71cba1e0c1c
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 10:51:28 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 17 Dec 2024 16:14:39 -08:00

x86/cpu: Introduce new microcode matching helper

The 'x86_cpu_id' and 'x86_cpu_desc' structures are very similar and
need to be consolidated.  There is a microcode version matching
function for 'x86_cpu_desc' but not 'x86_cpu_id'.

Create one for 'x86_cpu_id'.

This essentially just leverages the x86_cpu_id->driver_data field
to replace the less generic x86_cpu_desc->x86_microcode_rev field.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20241213185128.8F24EEFC%40davehans-spike.ostc.intel.com
---
 arch/x86/include/asm/cpu_device_id.h |  1 +
 arch/x86/kernel/cpu/match.c          | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/cpu_device_id.h b/arch/x86/include/asm/cpu_device_id.h
index e4121d9..9c77dbe 100644
--- a/arch/x86/include/asm/cpu_device_id.h
+++ b/arch/x86/include/asm/cpu_device_id.h
@@ -278,5 +278,6 @@ struct x86_cpu_desc {
 
 extern const struct x86_cpu_id *x86_match_cpu(const struct x86_cpu_id *match);
 extern bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_desc *table);
+extern bool x86_match_min_microcode_rev(const struct x86_cpu_id *table);
 
 #endif /* _ASM_X86_CPU_DEVICE_ID */
diff --git a/arch/x86/kernel/cpu/match.c b/arch/x86/kernel/cpu/match.c
index 8e7de73..2de2a83 100644
--- a/arch/x86/kernel/cpu/match.c
+++ b/arch/x86/kernel/cpu/match.c
@@ -86,3 +86,14 @@ bool x86_cpu_has_min_microcode_rev(const struct x86_cpu_desc *table)
 	return true;
 }
 EXPORT_SYMBOL_GPL(x86_cpu_has_min_microcode_rev);
+
+bool x86_match_min_microcode_rev(const struct x86_cpu_id *table)
+{
+	const struct x86_cpu_id *res = x86_match_cpu(table);
+
+	if (!res || res->driver_data > boot_cpu_data.microcode)
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(x86_match_min_microcode_rev);

