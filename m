Return-Path: <linux-tip-commits+bounces-4590-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62377A75BE7
	for <lists+linux-tip-commits@lfdr.de>; Sun, 30 Mar 2025 21:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C16443A79F1
	for <lists+linux-tip-commits@lfdr.de>; Sun, 30 Mar 2025 19:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A7F1465B4;
	Sun, 30 Mar 2025 19:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nCLPgGyt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/dSXxlxJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3C97082D;
	Sun, 30 Mar 2025 19:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743362600; cv=none; b=owxmonx7/SAqvRukQd4vbhGskC8nWTfB7R0t/LonufrgckNteMYAz24L2DEzJr1/rvw8ujaMBH2RB23dXvnUwSKwPuo+5ECctd9ixNyNaGalMG6AsZ6RdisWdYjapQ6DLaok0yniphJmiLVvEyIPA7kI8xMxA0b151bIpGXxdlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743362600; c=relaxed/simple;
	bh=zn4nCHOLF9fB0XAQT/8gM5ey68BkBLQRW35VGloRwv4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UC6T9s7z6lScIJ/DiVhOnczkdQ4Qw3n4A8cwl1aOE8xu98v+7jpLHow/APkYmjapy8tEssgaEIZyvYYo4vISuLnahF56WBxYLndaVF/m6K8DbRiGoEyUtdl89K7WA3CJHs9LjehDKR3pY+EGDTCgA9OROSwBvUYGrKgAbbDucuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nCLPgGyt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/dSXxlxJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 30 Mar 2025 19:23:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743362588;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhpcdIp4yJ0izvyO+CeFNzYLAjRWQqI1xQ39F/Kzlog=;
	b=nCLPgGytkf8BipHZhEEm+k1pksQIoA/emF41OXG0oXIjaD23CESIYGdEEJmQNa8IleL+IZ
	bPWkGKQsQ+n1xfIN80RzX4RoXsBtZ1MwhOz6LH0UwgWrZaTkrOhoaaHZXDJeuKbnkKOoDe
	Q+Z1xvjdrrGpfSOWU6janHhMI9rdLRxc7ARhG5AvkNjcScae0oTt6mOAj/TcyDY0s5a4Fw
	8eIui5wONQYOF3uF8dCwzNcNtIqdnmx5r35JDgNEvEvuOeg/LLWGrF++72zupUl5yNbWNj
	cNG8sIStrc54LRVw+1APJ5Y+KDJco+2qbzP6yDcyGtM49AP6+CTTfpctVwQ9iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743362588;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhpcdIp4yJ0izvyO+CeFNzYLAjRWQqI1xQ39F/Kzlog=;
	b=/dSXxlxJS8jKZtNu84e5U6SY+rT8HbX7UnoJC0ejlSzK2uxbj0D8N3nH2yWiRrfBxCDGXl
	7DYwBw0wRMx9hDCg==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/isolation: Make CONFIG_CPU_ISOLATION depend
 on CONFIG_SMP
Cc: kernel test robot <lkp@intel.com>, Oleg Nesterov <oleg@redhat.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250330134955.GA7910@redhat.com>
References: <20250330134955.GA7910@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174336258318.14745.15934634106640104624.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     9939188c730d68b8b6b5210b7770021656181730
Gitweb:        https://git.kernel.org/tip/9939188c730d68b8b6b5210b7770021656181730
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Sun, 30 Mar 2025 15:49:55 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 30 Mar 2025 21:08:05 +02:00

sched/isolation: Make CONFIG_CPU_ISOLATION depend on CONFIG_SMP

kernel/sched/isolation.c obviously makes no sense without CONFIG_SMP, but
the Kconfig entry we have right now:

	config CPU_ISOLATION
		bool "CPU isolation"
		depends on SMP || COMPILE_TEST

allows the creation of pointless .config's which cause
build failures.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250330134955.GA7910@redhat.com

Closes: https://lore.kernel.org/oe-kbuild-all/202503260646.lrUqD3j5-lkp@intel.com/
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 681f38e..ab9b0c2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -709,7 +709,7 @@ endmenu # "CPU/Task time and stats accounting"
 
 config CPU_ISOLATION
 	bool "CPU isolation"
-	depends on SMP || COMPILE_TEST
+	depends on SMP
 	default y
 	help
 	  Make sure that CPUs running critical tasks are not disturbed by

