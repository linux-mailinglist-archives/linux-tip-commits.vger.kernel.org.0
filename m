Return-Path: <linux-tip-commits+bounces-7774-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1249CE6EFE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Dec 2025 14:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACF653008FB6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Dec 2025 13:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF3D1E51E0;
	Mon, 29 Dec 2025 13:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IP2annq+"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E60318152
	for <linux-tip-commits@vger.kernel.org>; Mon, 29 Dec 2025 13:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767016711; cv=none; b=pWmUNubMdXqG8+ZkAuT1efq7yLO7DFePzkoiJUvhTc0lbDN39BeMTRoKB4I7dpf5S33lgDNm0VlorqWPNPQyU5BlhmldSAZ6LEbQQQbhgu5whV1W0sP6pp7O1K8T4ykSQjgEXx4f2nYJTuEDVOLRSE/Y8z65rpViiZ4dC5LZ19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767016711; c=relaxed/simple;
	bh=CbUYp8eke5wFqdyFofdKK1TbcpzA7CHWG8GpwsMWeto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hn0sjYYI55XQfIoVR4+oAJEm7K2wbR94yWVCNmIXNQy1xvdm+FSciEH+47hOHvenLTH524ZXS1tDfGOLOCBpFYUKwBWLz8WVIWzITfyguWwK6PezU6G0fnRvXqAsTPJZ0UtNoayBmZmzjcSfjq0JAiy56ID6ROwqT3nKj8tbihM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IP2annq+; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7a72874af1so1551708166b.3
        for <linux-tip-commits@vger.kernel.org>; Mon, 29 Dec 2025 05:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767016708; x=1767621508; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbUYp8eke5wFqdyFofdKK1TbcpzA7CHWG8GpwsMWeto=;
        b=IP2annq+PxylonYGnf4ODqPDdhtekpmNPQWl9DUmLd2ysSUNYToySkOl17poCWbQ0O
         soI/e/y9sATGlbf2b6JCaYmAEM3xPeqjVVKTtEI70T3A8r1P3r+kDzxbmANAuNiZL+o6
         zX6KjyEZGFw6cfRpl3q5YR0pJrFAwzmNMwUnWzm7EGizYBQwTnVkCYqCDlqAi0TjWkpk
         +Enalw7Dqu+s1IOOXQAAEmfXHlVH+bfB7r1jURKsBXbpckQbOtxUCmABMC4TeVZtKTci
         FNw0cXq9/4VJp/j5LuhtCCUaJNkG8CPRNJI5NNdW5FyW5vdKyL43A67Z6ou/0x6bx8Dn
         Mt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767016708; x=1767621508;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CbUYp8eke5wFqdyFofdKK1TbcpzA7CHWG8GpwsMWeto=;
        b=N7/58UbEOEl4RJ9NciMQ9uRwI7alEV8LPLWbjWsC6CDmwuN/2Bt5nU1PfE54XcjDqQ
         YWjJcgb2N2QEjKgVcFx8bqtYQxiC2Y6qI+UFP2oj3icG4KLrh2PVb2P5G7t2n++egqWS
         jGpfOCts3is2Bd3GBkU9RVkaiF8ZY6z3ix4dU8lZJ9sLbJrk7AxLkjmuAqO2/RgbN6MK
         r7kTMZhywgKOYTlpnXmd7h22pchpKEfRGWdiUAGK7ZDno9qXAr7/+iET6Hbwl/jh5jlP
         Uly2GYQwHMchXhwHAxUTuBxDxsAAjWNsbbN3dVXyyADIy6Wfmmj+MenetvC+hKemyzYr
         lPfA==
X-Forwarded-Encrypted: i=1; AJvYcCVkQfqmYaUERoSsPzGUU3oa85yOKtu7dFt1gJjx9/h13uupsN2uo0MyuzDfGJSoyF4qMY2v8yv7FiDlyQKeTvjCWw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx38THsBD+OapmIb7XD2qRJHYtqlalKHBnHVo7WT2u4sc2FQkiY
	h9V1GspxdN8owf8o7JI3N3yZwHR4E4WFLR6JU0EHaT/t34dgDgwd39xVAjp0hP1msie6TDemq+H
	AlHo5Yz7zvxgpiLbbj2bx547YgCbVpzkbXjv8Y07LsVXEp1MUXW86Z6A=
X-Gm-Gg: AY/fxX6AYYVAObrznOuQ9DJa6bf7Kf+OS4Ky2SyR9fE1OzNY8IPoBIccpLxgQwskLbR
	7k3UtpQX7l0SVlOysJfQV/qGtFE7ZHEJKu3vDTa6EpNhJyadoJj0RiTUvyiQXGSw3JvN1dEfGWI
	X33goTw48rc8W1Isy1Mqn/WTPjK+3QDE0fWAH0xUNARoetzGykUpi9bh9j9Cw53XNXzsRk9rtay
	GFBS5t+7rV49FuL5fkRUi4QMXz1jD/yixDNSl0e/t0GO+t3v3WmGGZoSlohQajLAIGmkkmDMtTx
	46EKHhSE4YVP2fG2OGi0JkvC
X-Google-Smtp-Source: AGHT+IGO6MoABPt9lpWXH4D4NpC+nEGOI6KLjXON4jPuGcTxRllAQBlHsOTOdPXT8w4jzdqKKxjSJ7vSN8a9o2S2IGs=
X-Received: by 2002:a17:907:6e9f:b0:b73:8cea:62b3 with SMTP id
 a640c23a62f3a-b803704ffd7mr3084766766b.41.1767016707606; Mon, 29 Dec 2025
 05:58:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176478073513.498.15089394378873483436.tip-bot2@tip-bot2> <20251229125109.1995077-1-CruzZhao@linux.alibaba.com>
In-Reply-To: <20251229125109.1995077-1-CruzZhao@linux.alibaba.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 29 Dec 2025 14:58:16 +0100
X-Gm-Features: AQt7F2psSqdUkvELM_p2lhfUwfT1gwYwvORg5P1Yq7iNhqPGuZbDS1EhmQ7JZ9Q
Message-ID: <CAKfTPtCQW_Oj+P6nGx0nVO01CahSEqxuToO8kg=oe3yfuViOwg@mail.gmail.com>
Subject: Re: [tip:sched/urgent] sched/fair: Clear ->h_load_next when
 unregistering a cgroup
To: Cruz Zhao <CruzZhao@linux.alibaba.com>
Cc: tip-bot2@linutronix.de, linux-kernel@vger.kernel.org, 
	linux-tip-commits@vger.kernel.org, mingo@kernel.org, 
	peng_wang@linux.alibaba.com, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cruz,

On Mon, 29 Dec 2025 at 13:51, Cruz Zhao <CruzZhao@linux.alibaba.com> wrote:
>
> Hi Ingo/Peter/all,
>
> I noticed that the following patch has been queued in the
> tip:sched/urgent branch for some time but hasn't yet made
> it into mainline:
> https://lore.kernel.org/all/176478073513.498.15089394378873483436.tip-bot=
2@tip-bot2/
>
> Could you please check if there's anything blocking its
> merge? I wanted to ensure it doesn=E2=80=99t get overlooked.

From an off list discussion w/ Peter, we need to check that this patch
is not hiding the root cause that task_h_load is not called in the
right context i.e. with rcu_read_lock(). Peter pointed out one place
in numa [1]

[1] https://lore.kernel.org/all/20251015124422.GD3419281@noisy.programming.=
kicks-ass.net/

Vincent

>
> Thanks for your time and reviewing!
>
> Best regards,
> Cruz Zhao

