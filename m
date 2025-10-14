Return-Path: <linux-tip-commits+bounces-6815-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C2DBDA24F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 16:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DF36188ACFD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Oct 2025 14:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E862FDC43;
	Tue, 14 Oct 2025 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WzBMxbxl"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD622FE071
	for <linux-tip-commits@vger.kernel.org>; Tue, 14 Oct 2025 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453216; cv=none; b=sUxFCdcvyi03Y5DMggOW5T2Nxr8bLyEAIcsIenerHoSwISwD/EyqqUL3KtrK/RBglMh3J0cCMeGOIrm5huYoiYCjKmDKx1fgXBmP6RFwKXbl5nx40TOcgoP35BaEmO8udNU9SO3VjY3UEkfpRkRCGup7opldfA14HbHlYlaJnUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453216; c=relaxed/simple;
	bh=ND/vJuh1HCmw2CAtnjEyZ4WbjNWTAzpzK3UuBwHAQn8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aIx9dfVTuKxMmRpJ3vdrsFDLwaLCMo1OCxczgtEhEGAoW4C+jHJ3yxdjDfR8x3RxWDi1vLvfHQrJYVe+YBGva0oVRtg33lxaY1awRl06Yj1Qcq2TYLt/jygHMO4EhId8ZAu+3vjUXgWl5D6IKiKNDdF9wb0u9dp3I0nvl+/R7Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WzBMxbxl; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63b9da76e42so4748564a12.0
        for <linux-tip-commits@vger.kernel.org>; Tue, 14 Oct 2025 07:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760453212; x=1761058012; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ND/vJuh1HCmw2CAtnjEyZ4WbjNWTAzpzK3UuBwHAQn8=;
        b=WzBMxbxlhs8Ihal984ylAm2Ns2Tp/2IJw0g1pKGLYdD/ZvVQnklkXe3+CYzB36uu79
         Yt5b+Pb2gp1osJA5ts0NlpMGC/xVR4B25PZIq9nHGaMh6WU8bb15gZVMIum2t8B0QvXh
         /9KrfDDDXLacpf0oYvLVzxoYm3Rx/2e5ztRzJZn7yZMLAAKJ8y5juO/JiHW/Ozj+JL9m
         DVp1W4kYLxVY3sSXETtyW/HWFb5qX42O/L0VsAhBPArHp1Kov7iTx9RaGOJNEhiJsLzO
         YjHdoAsld3g7QaKoEH2oj9q6OgsUWzCT9SNwbWwTs87zxSMJrJKt1AQkolvL7yFG1PCF
         QmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760453212; x=1761058012;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ND/vJuh1HCmw2CAtnjEyZ4WbjNWTAzpzK3UuBwHAQn8=;
        b=R1mYll9s/2XtylbyHUrntlbbZDok1i47afmgvruqCwxD7Xsisvxl9nTYv4+bk9R4GJ
         Sgyk4TWS8MlW2LcxJ8IOvTZmA/wHI0vp+OkhTEVKxscTlQoPYADQe6/ip1B4zEUFBjw5
         Kwfo0Ttar/I2hXAnfrAv+49C7yvq34ePOFwEx0YOi2IfXgwiypesVYWiIKoHPNi2G389
         3uWQGeFs77hC/XkiJH6bU7SZrfz3egihOHOzy7pDIQvWOBs2CG50x6V78D5RYm09IcfI
         qu3LNX+YnM9YL/2ENcaAbc6GAOY8lkksvV7QiQb8HYomtqMdpqjAd+Bpa7Cr89u1M6u9
         QwIw==
X-Forwarded-Encrypted: i=1; AJvYcCVurxUoz0gQGdCKiXda/vgS9yxqg0VgIZ74HnaL0tU7KkF7bV7pCcO0Z5DzZ5UfKQnJl1TLKJdIj6e3kErpb6tZhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzlEgqSiDdoUzusOmWBMndIMzXCoPwsnc5qRZUsUWnBVkeNeAbH
	sq5imitUAA94e7HMW+UmX7dR3zFRJgWIMrmdF5szWKEiy8RcPSI/AIWvhU+/TAx0QFM=
X-Gm-Gg: ASbGncvEr509S4Lm3AGJ+tGxhTa82pxK8aiZ9xTibG5hy5vS3jlZ8HJQfm+X2Lbq2N8
	iVGzpZmPgOrygyKR73iTvM66eVJIQX6OoCIA5hFoAsN5qlMx5qtPLmTPXQ0suepr3MikhE98d41
	v+5vNE2puKklNGszSZIq+hHeaKe25zneUBBaD6s2gCazajpkDytuWsMI0l7B9HEz4xkc7aH76j0
	IrVLFGdLP3Q8K+b3/ER3jLL1ItoYnQ8A1GADNQ6wi75PYMBpFjvD0O/XKdIoQMd4An8n3cQ2msg
	PI1axJNUWqec8jISKFlmylxYb/ZYJ8kkYwSQBHkGRjqTnnuArBnnQzuSJ1TrsAT80bh7YrztK7u
	qtf2RkTNeCts0BdByRyYp0ORLqTKwEI6OOWtv6Yvx0pHbV3g7nrs7miXPB0gpYn9cdmT9GfGFvb
	dUAHyDTR4Sk253qHSIQfHQpJp2lRQKgG9PSwVo5+U6WxzckI2HzdM15cdWfXjeNcg=
X-Google-Smtp-Source: AGHT+IFhS9S/g0bPhwV48NSh2gdWVNnegNtV2ygKzFS/LP1cVSmHwQKZvr2j+fay1Ei5C2aPjby/Sg==
X-Received: by 2002:a17:907:2d1e:b0:b45:cd43:8a93 with SMTP id a640c23a62f3a-b50acb0e5a8mr2818530066b.62.1760453212362;
        Tue, 14 Oct 2025 07:46:52 -0700 (PDT)
Received: from ?IPV6:2003:e5:873f:400:7b4f:e512:a417:5a86? (p200300e5873f04007b4fe512a4175a86.dip0.t-ipconnect.de. [2003:e5:873f:400:7b4f:e512:a417:5a86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d61cd9f5sm1157893266b.21.2025.10.14.07.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 07:46:52 -0700 (PDT)
Message-ID: <407933ba-536e-490b-a7b3-eb81cb75cd0c@suse.com>
Date: Tue, 14 Oct 2025 16:46:51 +0200
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [tip: x86/core] x86/alternative: Patch a single alternative
 location only once
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
References: <20250929112947.27267-4-jgross@suse.com>
 <176043135449.709179.18067035380831847643.tip-bot2@tip-bot2>
 <20251014125909.GAaO5JHU_cgsPgstc_@fat_crate.local>
 <4fd058ac-3af5-4778-842c-9a185d828c9d@suse.com>
 <20251014141245.GCaO5aXSQqglFrT9Iy@fat_crate.local>
 <c0fb45d5-c4a0-498d-8378-dd96ec261c8c@suse.com>
 <20251014142656.GFaO5dsDlJ6d_WY_fk@fat_crate.local>
 <bafc306d-b43e-464f-94e6-f59eeaa7d690@suse.com>
 <20251014143910.GHaO5gjk3IRSLRwqhY@fat_crate.local>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <20251014143910.GHaO5gjk3IRSLRwqhY@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------unXNy7P1rRHRHSennmTtZ0Gc"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------unXNy7P1rRHRHSennmTtZ0Gc
Content-Type: multipart/mixed; boundary="------------MgQOQdfIx1ZIRj31XPx1A2xU";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org
Message-ID: <407933ba-536e-490b-a7b3-eb81cb75cd0c@suse.com>
Subject: Re: [tip: x86/core] x86/alternative: Patch a single alternative
 location only once
References: <20250929112947.27267-4-jgross@suse.com>
 <176043135449.709179.18067035380831847643.tip-bot2@tip-bot2>
 <20251014125909.GAaO5JHU_cgsPgstc_@fat_crate.local>
 <4fd058ac-3af5-4778-842c-9a185d828c9d@suse.com>
 <20251014141245.GCaO5aXSQqglFrT9Iy@fat_crate.local>
 <c0fb45d5-c4a0-498d-8378-dd96ec261c8c@suse.com>
 <20251014142656.GFaO5dsDlJ6d_WY_fk@fat_crate.local>
 <bafc306d-b43e-464f-94e6-f59eeaa7d690@suse.com>
 <20251014143910.GHaO5gjk3IRSLRwqhY@fat_crate.local>
In-Reply-To: <20251014143910.GHaO5gjk3IRSLRwqhY@fat_crate.local>

--------------MgQOQdfIx1ZIRj31XPx1A2xU
Content-Type: multipart/mixed; boundary="------------TnccYDscM5BoUvuG4xFFEtIa"

--------------TnccYDscM5BoUvuG4xFFEtIa
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTQuMTAuMjUgMTY6MzksIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVHVlLCBP
Y3QgMTQsIDIwMjUgYXQgMDQ6MzE6MzFQTSArMDIwMCwgSsO8cmdlbiBHcm/DnyB3cm90ZToN
Cj4+IEkgaGF2ZSB0aGlzIGhlcmUgaW4gdGhlIGNvbW1pdCBtZXNzYWdlOg0KPj4NCj4+ICAg
IC0gSW4gY2FzZSBvZiByZXBsYWNpbmcgYW4gaW5kaXJlY3Qgd2l0aCBhIGRpcmVjdCBjYWxs
IHVzaW5nIHRoZQ0KPj4gICAgICBBTFRfRkxBR19ESVJFQ1RfQ0FMTCBmbGFnLCB0aGVyZSBp
cyBubyBsb25nZXIgdGhlIG5lZWQgdG8gaGF2ZSB0aGF0DQo+PiAgICAgIGluc3RhbmNlIGJl
Zm9yZSBhbnkgb3RoZXIgaW5zdGFuY2VzIGF0IHRoZSBzYW1lIGxvY2F0aW9uICh0aGUNCj4+
ICAgICAgb3JpZ2luYWwgaW5zdHJ1Y3Rpb24gaXMgbmVlZGVkIGZvciBmaW5kaW5nIHRoZSB0
YXJnZXQgb2YgdGhlIGRpcmVjdA0KPj4gICAgICBjYWxsKS4NCj4+DQo+PiB3aGljaCBpcyBl
eHBsYWluaW5nIHdoeSB0aGUgcHJvYmxlbSBpcyBvY2N1cnJpbmcuIElzbid0IHRoYXQgZW5v
dWdoPw0KPiANCj4gSSBjYW4gZ3Vlc3Mgd2hhdCB0aGlzIGlzIGFib3V0IGJ1dCBhIGNvbmNy
ZXRlIGV4YW1wbGUgaGVyZSB3b3VsZCBtYWtlIGl0DQo+IGEgbG90IGNsZWFyZXIsIEknZCBz
YXkuDQoNCk9rYXksIEknbGwgZXhwYW5kIHRoYXQgd2l0aCB0aGUgY29uY3JldGUgZXhhbXBs
ZS4NCg0KDQpKdWVyZ2VuDQo=
--------------TnccYDscM5BoUvuG4xFFEtIa
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------TnccYDscM5BoUvuG4xFFEtIa--

--------------MgQOQdfIx1ZIRj31XPx1A2xU--

--------------unXNy7P1rRHRHSennmTtZ0Gc
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmjuYlsFAwAAAAAACgkQsN6d1ii/Ey82
ugf/VnvqJ3RlCNQfLQzT9fQvKSfYl2rZXlCA3Ref0fvAi+Ya84LM0Di4pFcLsCzccMjuvXlu3B0M
qAtmDiu0WxdlyWu0teYLMHEn7uqPWHPS+xgfIU9i5qBGpR0KZQ87tExMoIfLW1mAWVMK4FQ28x9g
zT4r2CP7NOSVT1eUbMpBNw8xic2XThPEZHukFkFUGYurXlh8n+8wchs2yutw0xCrQ6GZ3mwh7C08
dg6f44qex4XkdbKHw2KZFLBVH5gVzMF68ErMHnKt2Ra9trhWcISGWn2XyCQ/jLKqhTVemSdVtUCq
Ye5TXX5ecgg0LEzFc/GrOHUBwcd8sia7KmdFrpwWZA==
=Lj8d
-----END PGP SIGNATURE-----

--------------unXNy7P1rRHRHSennmTtZ0Gc--

