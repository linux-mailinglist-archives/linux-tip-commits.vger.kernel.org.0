Return-Path: <linux-tip-commits+bounces-7773-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B426ACE6C74
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Dec 2025 13:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1CB13004858
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Dec 2025 12:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C39531AF2A;
	Mon, 29 Dec 2025 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KX9jP2o6"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34AC31AF22;
	Mon, 29 Dec 2025 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767012695; cv=none; b=j578Pn0A8OlaKc312sseHtUyVkbtqr70t5vDW1Z+55QHShSDlrBdNXXzrtfGRc6pl/et+x23ajbyuWEzYWLYMt7E4xRORY5gEQTwcQpfSo9yqfMNe5p68+X45ZeRHgS64zFQRP3MORCXniOracox53i9oL0actqXOGA/EXEL/e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767012695; c=relaxed/simple;
	bh=GACN5b7OD7Yf/DdszATC3S2wBrrgqKkYtWM2MlugHq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZCJCxcDYhkX+h3B4qNzpVgP2S9uJLCSYmXtODAGR2D4y1PQxcxqorcqIMiCJmGhQHtl05t4afpwqmmgCHZiVVSKOuuFDGbRUKUrsnWd+Ipc8p66jfy9eM7HNB4e3/EOZ5GNwm5dmYG4T2yXxgkimCQKZQ9nrWOw3jHu+zfHOCjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KX9jP2o6; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767012684; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=3jhmDidTaBYgrIve7lUqCu+LhN6ilCX4OqjvJurzvZ4=;
	b=KX9jP2o64fW3QJagqTBNRP8qRoKz7r44fpaBRF2xDgZoXXMXlGdaLOT503U+fqGVxaG79xKm9+Xh1feWsa25OqHcQNyGQeIps1od+okF/vDlIxcyPvUupBaWzCeS9LwEwEWu8+hgbt8y1nVMDJBUkcaehffnKqYr2KThnB/ys2I=
Received: from j63c11469.sqa.eu95.tbsite.net(mailfrom:CruzZhao@linux.alibaba.com fp:SMTPD_---0WvtRiBf_1767012669 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Dec 2025 20:51:23 +0800
From: Cruz Zhao <CruzZhao@linux.alibaba.com>
To: tip-bot2@linutronix.de
Cc: CruzZhao@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	mingo@kernel.org,
	peng_wang@linux.alibaba.com,
	vincent.guittot@linaro.org,
	x86@kernel.org
Subject: Re: [tip:sched/urgent] sched/fair: Clear ->h_load_next when unregistering a cgroup
Date: Mon, 29 Dec 2025 20:50:54 +0800
Message-ID: <20251229125109.1995077-1-CruzZhao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <176478073513.498.15089394378873483436.tip-bot2@tip-bot2>
References: <176478073513.498.15089394378873483436.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=Y
Content-Transfer-Encoding: 8bit

Hi Ingo/Peter/all,

I noticed that the following patch has been queued in the
tip:sched/urgent branch for some time but hasn't yet made
it into mainline: 
https://lore.kernel.org/all/176478073513.498.15089394378873483436.tip-bot2@tip-bot2/

Could you please check if there's anything blocking its
merge? I wanted to ensure it doesn’t get overlooked.

Thanks for your time and reviewing! 

Best regards,
Cruz Zhao

