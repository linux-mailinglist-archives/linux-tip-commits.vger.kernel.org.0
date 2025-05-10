Return-Path: <linux-tip-commits+bounces-5517-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0A8AB24ED
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 May 2025 20:18:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88B01B679FA
	for <lists+linux-tip-commits@lfdr.de>; Sat, 10 May 2025 18:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26446266B74;
	Sat, 10 May 2025 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastemail60.com header.i=@fastemail60.com header.b="HmM4yj7G"
Received: from mail.fastemail60.com (mail.fastemail60.com [102.222.20.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A93D265CB3
	for <linux-tip-commits@vger.kernel.org>; Sat, 10 May 2025 18:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=102.222.20.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746901136; cv=none; b=nJih8/EHplCGY2RXY3F02w6V+OgBYVDD++d2LFcEjpxMoHqdtmsNblYwJkY6jeor6KMARKVM8VfykVasRB72g3tWAHM+pyFug1G3ekCuzYN/zhhB1eunHebONn/q2C1vvuEEbfCkZ9m+SieXEoRRB4bSjPxL4n2dKFWy27chOn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746901136; c=relaxed/simple;
	bh=0kM12Ki2v7eI61I1WvQrX7nQw+DKE1uiGUA45uahRZc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GBiPSfkecM3kWoPTL2qtY5mnn0Py1YwrDS+kA9SuSbbhr5cNuPuYjZEfswfV/uQaar0lp9lKHkNMP55cC+H8M7c5E08v0WOSe53MmUHDjwgXiq0D6OX1fapqDp6V87q9vX8EjG9vtS4uJEfxzt9c/Cx7h1gflsXJBY0LnfFhRFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fastemail60.com; spf=none smtp.mailfrom=fastemail60.com; dkim=pass (2048-bit key) header.d=fastemail60.com header.i=@fastemail60.com header.b=HmM4yj7G; arc=none smtp.client-ip=102.222.20.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fastemail60.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fastemail60.com
Received: from fastemail60.com (unknown [194.156.79.202])
	by mail.fastemail60.com (Postfix) with ESMTPA id D9FED887AC3
	for <linux-tip-commits@vger.kernel.org>; Sat, 10 May 2025 16:31:54 +0200 (SAST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.fastemail60.com D9FED887AC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastemail60.com;
	s=202501; t=1746887516;
	bh=0kM12Ki2v7eI61I1WvQrX7nQw+DKE1uiGUA45uahRZc=;
	h=Reply-To:From:To:Subject:Date:From;
	b=HmM4yj7G1dXej8WqbKd8hVD/fnfNNu76wlRDjlp9CX4+x/DoszjXamWtB5JUcr+1+
	 K++u78MTJKzMAQvaDZpELssh434Thm0KsqmDsPucJmwS0Olq5P+L+f7qXplmSHHPVC
	 eSaNZn8o3aXle7WLMtSQgid5l48bn3xpwgcsELT3dNMqG8dAb44V1x2P4AyVRPWf5P
	 gfdLdabJZqLqcTcl3dkpTZQeAvP7rNWInnthXVhTXc+L4aZkmhc/vpofCzOKnaKYlq
	 /QeY91bP4z5/Qe1f6uae/pcbaWPEc1rv2RngyVkYWX+nZ7tYgc1BHOpxEV2LunFvRE
	 lTBatyga6NaRg==
Reply-To: import@herragontradegroup.cz
From: Philip Burchett<info@fastemail60.com>
To: linux-tip-commits@vger.kernel.org
Subject: Inquiry
Date: 10 May 2025 10:31:54 -0400
Message-ID: <20250510103154.D0D3F7FB04463244@fastemail60.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.4 (mail.fastemail60.com [0.0.0.0]); Sat, 10 May 2025 16:31:56 +0200 (SAST)

Greetings, Supplier.

Please give us your most recent catalog; we would want to order=20
from you.

I look forward to your feedback.


Philip Burchett

